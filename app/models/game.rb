class Game < ActiveRecord::Base
  belongs_to :favorite, class_name: "Competitor", foreign_key: "favorite_id"
  belongs_to :underdog, class_name: "Competitor", foreign_key: "underdog_id"
  belongs_to :log, class_name: "Log", foreign_key: "log_id", inverse_of: :games

  def f_implied_odds
    self.f_odds.abs.fdiv((self.f_odds.abs + 100)).round(3)
  end

  def d_implied_odds
    100.fdiv((self.d_odds.abs + 100)).round(3)
  end

  def neutral_field_win_percentage(this_team, opponent)
    self.send(this_team).team_expected_win_percentage *
    (1 - self.send(opponent).team_expected_win_percentage)
  end

  def adjusted_neutral_field_win_percentage(this_team, opponent)
    sum = neutral_field_win_percentage(this_team, opponent) +
          neutral_field_win_percentage(opponent, this_team)

    neutral_field_win_percentage(this_team, opponent).fdiv(sum)
  end

  def adjusted_win_percentage(team)
    home_team = self.send(self.home_team)
    other_team = self.home_team == :favorite ? :underdog : :favorite

    if home_team == self.send(team)
      (1.08 * adjusted_neutral_field_win_percentage(team, other_team)).round(3)
    else
      (1 - adjusted_win_percentage(other_team)).round(3)
    end
  end

  def advantage_for(team)
    implied_odds = team == :favorite ? f_implied_odds : d_implied_odds
    adjusted_win_percentage(team) - implied_odds
  end

  def advantage
    return advantage_for(:favorite).round(3) if advantage_for(:favorite) > 0
    advantage_for(:underdog).round(3)
  end

  def pick
    return :none if advantage <= 0.01

    advantage_for(:favorite) > 0 ? :favorite : :underdog
  end

  def bet
    return 0 if pick == :none

    if pick == :favorite
      factor = ((adjusted_win_percentage(:favorite)*((100/f_odds.abs) + 1) - 1)/(100/f_odds.abs)) * self.log.beginning_balance
    else
      factor = ((adjusted_win_percentage(:underdog) * ((d_odds/100) + 1) - 1)/(d_odds/100)) * self.log.beginning_balance
    end

    self.log.kelly * factor
  end

end
