class CreatePits < ActiveRecord::Migration
  def change
    create_table :pits do |t|
      t.string :name, null: false
      t.string :team_name, null: false
      
      t.integer :mlb_player_id
      
      t.boolean :reliever
      
      t.integer :team_id
      t.timestamps null: false
    end
    
    add_index :pits, :mlb_player_id
    add_index :pits, [:name, :team_name]
  end
end
