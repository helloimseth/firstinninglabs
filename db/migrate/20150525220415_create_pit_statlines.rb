class CreatePitStatlines < ActiveRecord::Migration
  def change
    create_table :pit_statlines do |t|
      t.integer :pit_id, null: false
      
      t.integer :w
      t.integer :l
      t.float :era
      t.integer :gs
      t.integer :g
      t.float :ip
      t.integer :h
      t.integer :er
      t.integer :hr
      t.integer :so
      t.integer :bb
      t.float :whip
      t.float :k_per_9
      t.float :bb_per_9
      t.float :fip
      t.float :war
      
      t.timestamps null: false
    end
  end
end
