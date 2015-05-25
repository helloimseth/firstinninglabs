class Pit < ActiveRecord::Base
  belongs_to :team
  has_many :statlines, class_name: "PitStatline", 
                       foreign_key: "pit_id", inverse_of: :pit
  
  CSV_TAGS = ["uzips", "steameru"]
                       
  def self.find_by_mlb_id(id)
   Pit.find_by(mlb_player_id: id)
  end

  def self.fetch_csv_from(source)!
   agent = Mechanize.new
   page = agent.get( 'http://www.fangraphs.com/projections.aspx?pos=all&stats=pit&type=' + source)

   form = page.form
   form.add_field!('__EVENTARGUMENT','')
   form.add_field!('__EVENTTARGET','ProjectionBoard1$cmdCSV')
   page = agent.submit(form)

   page.save
  end
  
  def self.refresh_stats!
    CSV_TAGS.each do |tag|
      stats = Pit.fetch_csv_from(tag)

      File.readlines(stats).each_with_index do |stat_line, index|
        next if index == 0

        stats = stat_line.chomp.gsub('"','').split(',')
        
        if stats.length > 19
          stats.pop
          stats.delete_at(7)
        end
        
        mlb_player_id = stats.pop.to_i       
        player = Pit.find_by_mlb_id(mlb_player_id) ||
                 Pit.create!(name: stats[0], team: stats[1], mlb_player_id: mlb_player_id)

        PitStatline.add_stats_for!(player, stats.drop(2), tag)
      end
    end
  end
  
  def team=(value)
    if value.length > 2
      self.team_name = value

      team = Team.find_by(name: value)
      self.team_id = team.id
    else
      self.team_name = 'Free Agent'
    end
  end
end
