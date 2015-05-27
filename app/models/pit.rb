class Pit < ActiveRecord::Base
  belongs_to :team
  has_many :statlines, class_name: "PitStatline",
                       foreign_key: "pit_id", inverse_of: :pit,
                       dependent: :destroy

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

   page.body
  end

  def self.refresh_stats!
    CSV_TAGS.each do |tag|
      stats = Pit.fetch_csv_from(tag).split("\n")

      stats.each_with_index do |stat_line, index|
        next if index == 0

        stats = stat_line.chomp.gsub('"','').split(',')

        mlb_player_id = stats.pop.to_i

        if stats.length > 19
          stats.pop
          stats.delete_at(7)
        end

        player = Pit.find_by_mlb_id(mlb_player_id) ||
                  Pit.create!(name: stats[0],
                              team: stats[1],
                              mlb_player_id: mlb_player_id)

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

  def current_zips
    self.statlines.where(source: true).last
  end

  def current_steamer
    self.statlines.where(source: false).last
  end

  def expected_war_as_sp
    zips = self.current_zips
    steamer = self.current_steamer
    
    ((zips.war/zips.gs) + (steamer.war/steamer.gs))/2
  end

end
