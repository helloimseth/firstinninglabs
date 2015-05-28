class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :day
      t.date :date
      t.float :beginning_balance
      t.float :kelly
      t.timestamps null: false
    end

    remove_column :games, :date, :date
    add_column :games, :log_id, :integer
  end
end
