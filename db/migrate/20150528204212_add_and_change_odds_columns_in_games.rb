class AddAndChangeOddsColumnsInGames < ActiveRecord::Migration
  def change
    add_column :games, :f_odds, :integer
    remove_column :games, :sportsbook_odds
    add_column :games, :d_odds, :integer
  end
end
