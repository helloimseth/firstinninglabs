class CreateBats < ActiveRecord::Migration
  def change
    create_table :bats do |t|
      t.string :name, null: false
      t.string :team_name, null: false
      
      t.integer :playerid
      
      t.integer :team_id
      t.timestamps null: false
    end
    
    add_index :bats, :playerid
    add_index :bats, [:name, :team_name]
  end
end
