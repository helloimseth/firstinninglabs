class Game < ActiveRecord::Base
  belongs_to :favorite, class_name: "Competitor", foreign_key: "favorite_id"
  belongs_to :underdog, class_name: "Competitor", foreign_key: "underdog_id"
  belongs_to :log, class_name: "Log", foreign_key: "log_id", inverse_of: :games

  def f_implied_odds
    self.f_odds.abs.fdiv((self.f_odds.abs + 100))
  end

  def d_implied_odds
    100.fdiv((self.d_odds.abs + 100))
  end

  def filled_out?
    !self.send(:favorite).nil? &&
    !self.send(:underdog).nil? &&
    !self.send(:favorite).team_expected_win_percentage.nil? &&
    !self.send(:underdog).team_expected_win_percentage.nil?
  end

  def neutral_field_win_percentage(team)
    other_team = team == :favorite ? :underdog : :favorite

    self.send(team).team_expected_win_percentage *
    (1 - self.send(other_team).team_expected_win_percentage)
  end

  def adjusted_neutral_field_win_percentage(team)
    other_team = team == :favorite ? :underdog : :favorite

    sum = neutral_field_win_percentage(team) + neutral_field_win_percentage(other_team)

    neutral_field_win_percentage(team).fdiv(sum)
  end

  def adjusted_win_percentage(team)
    other_team = self.home_team == :favorite ? :underdog : :favorite

    if self.send(self.home_team) == self.send(team)
      (1.08 * adjusted_neutral_field_win_percentage(team)).round(3)
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
    return :none if !self.filled_out? || advantage <= 0.01

    advantage_for(:favorite) > 0 ? :favorite : :underdog
  end

  def bet
    return 0 if pick == :none

    if pick == :favorite
      factor = ((adjusted_win_percentage(:favorite) * ((100.fdiv(f_odds.abs)) + 1) - 1).fdiv((100.fdiv(f_odds.abs)))) * self.log.beginning_balance
    else
      factor = ((adjusted_win_percentage(:underdog) * ((d_odds.fdiv(100)) + 1) - 1).fdiv((d_odds.fdiv(100)))) * self.log.beginning_balance
    end

    (self.log.kelly * factor).round(2)
  end

  def to_win
    return (100.fdiv(f_odds.abs) * bet).round(2) if pick == :favorite
    (d_odds.fdiv(100) * bet).round(2)
  end

  def expected_value
    loser = self.pick == :favorite ? :underdog : :favorite

    (to_win * adjusted_win_percentage(self.pick) +
    (bet * -1) * adjusted_win_percentage(loser)).round(2)
  end

  def result
    self.winner == self.pick ? to_win : bet * -1
  end

end
