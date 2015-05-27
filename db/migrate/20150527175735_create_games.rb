class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :favorite_id
      t.integer :underdog_id
      t.float :sportsbook_odds
      t.float :our_odds

      t.timestamps
    end
  end
end
