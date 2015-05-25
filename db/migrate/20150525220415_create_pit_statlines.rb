class CreatePitStatlines < ActiveRecord::Migration
  def change
    create_table :pit_statlines do |t|
      t.integer :pit_id, null: false
      
      t.integer :W
      t.integer :L
      t.float :ERA
      t.integer :GS
      t.integer :G
      t.float :IP
      t.integer :H
      t.integer :ER
      t.integer :HR
      t.integer :SO
      t.integer :BB
      t.float :WHIP
      t.float :"K/9"
      t.float :"BB/9"
      t.float :FIP
      t.float :WAR
      
      t.timestamps null: false
    end
  end
end
