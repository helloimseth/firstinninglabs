class AddHomeTeamToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_team, :string
  end
end
