class Game < ActiveRecord::Base
  belongs_to :favorite, class_name: "Competitor", foreign_key: "favorite_id"
  belongs_to :underdog, class_name: "Competitor", foreign_key: "underdog_id"
  belongs_to :log, class_name: "Log", foreign_key: "log_id", inverse_of: :games

  def f_implied_odds
    self.f_odds.abs/(self.f_odds.abs + 100)
  end

  def d_implied_odds
    100/self.d_odds.abs + 100
  end

  
end
