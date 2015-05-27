class Competitor < ActiveRecord::Base
  belongs_to :team
  has_one :game_as_favorite, class_name: "Game",
                             foreign_key: "favorite_id",
                             inverse_of: :favorite
  has_one :game_as_underdog, class_name: "Game",
                             foreign_key: "underdog_id",
                             inverse_of: :underdog
  belongs_to :starter, class_name: "Pit", foreign_key: :sp, inverse_of: :starts

  BATTING_ORDER_XPA = {
    1 => 4.703703704,
    2 => 4.586419753,
    3 => 4.475308642,
    4 => 4.37654321,
    5 => 4.277777778,
    6 => 4.166666667,
    7 => 4.055555556,
    8 => 3.938271605,
    9 => 3.814814815
  }


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

  def starter=(id)
    self.sp = id

    self.sp_expected_war = Pit.find(id).expected_war_as_sp
  end

  def relievers=(arr)
    self.rps = arr.map(&:to_i)

    self.rp_expected_war = arr.map {|rp| Pit.find(rp).expected_war_as_rp}.inject(:+)
  end

  def relievers
    self.rps.map {|rp| Pit.find(rp.to_i)}
  end

  def batting_order=(arr)
    self.lineup= arr

    self.off_expected_war = arr.map.with_index do |bat_id, idx|
      batter = Bat.find(bat_id.to_i)

      BATTING_ORDER_XPA[idx.to_i + 1] * batter.war_per_pa
    end.inject(:+)
  end

end
