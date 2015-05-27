class Bat < ActiveRecord::Base
  belongs_to :team
  has_many :statlines, class_name: "BatStatline", foreign_key: "bat_id", inverse_of: :bat
  
  def self.find_by_mlb_id(id)
    Bat.find_by(mlb_player_id: id)
  end
  
  def self.fetch_stat_csv!
    agent = Mechanize.new
    page = agent.get( 'http://www.fangraphs.com/projections.aspx?pos=all&stats=bat&type=uzips')

    form = page.form
    form.add_field!('__EVENTARGUMENT','')
    form.add_field!('__EVENTTARGET','ProjectionBoard1$cmdCSV')
    page = agent.submit(form)
    
    page.body
  end
  
  def self.refresh_stats!
    stats = Bat.fetch_stat_csv!.split("\n")

    stats.each_with_index do |stat_line, index|
      next if index == 0

      stats = stat_line.chomp.gsub('"','').split(',')
      
      mlb_player_id = stats.pop.to_i       
      player = Bat.find_by_mlb_id(mlb_player_id) ||
               Bat.create!(name: stats[0], team: stats[1], mlb_player_id: mlb_player_id)

      BatStatline.add_stats_for!(player, stats.drop(2))
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
  
  def current_statline
    self.statlines.last
  end

  def method_missing(name)
    self.current_statline.send(name)
  end   
end


                 