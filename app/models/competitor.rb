class Competitor < ActiveRecord::Base
  belongs_to :team
  has_one :game_as_favorite, class_name: "Game",
                             foreign_key: "favorite_id",
                             inverse_of: :favorite
  has_one :game_as_underdog, class_name: "Game",
                             foreign_key: "underdog_id",
                             inverse_of: :underdog

  def game
    self.game_as_favorite || self.game_as_underdog
  end

  def team_expected_win_percentage
    if self.off_expected_war && self.sp_expected_war && self.rp_expected_war
      (self.off_expected_war +
       self.sp_expected_war +
       self.rp_expected_war + 49.9) / 162
     end
  end
end
