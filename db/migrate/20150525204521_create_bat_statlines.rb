class CreateBatStatlines < ActiveRecord::Migration
  def change
    create_table :bat_statlines do |t|
      t.integer :player_id
      
      t.integer :g
      t.integer :pa
      t.integer :ab
      t.integer :h
      t.integer :doubles
      t.integer :triples
      t.integer :hr
      t.integer :r
      t.integer :rbi
      t.integer :bb
      t.integer :so
      t.integer :hbp
      t.integer :sb
      t.integer :cs

      t.float :avg
      t.float :obp
      t.float :slg
      t.float :ops
      t.float :woba
      t.float :fld
      t.float :bsr
      t.float :war
      
      t.timestamps null: false
    end
  end
end
