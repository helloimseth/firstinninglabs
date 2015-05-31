class Log < ActiveRecord::Base
  has_many :games, class_name: "Game", foreign_key: :log_id

  def sum_of_games(stat)
    self.games.select(&:filled_out?).map(&stat).inject(:+)
  end

  def ending_balance
    days_results = sum_of_games(:result)
    self.beginning_balance + days_results unless days_results.nil?
  end
end
