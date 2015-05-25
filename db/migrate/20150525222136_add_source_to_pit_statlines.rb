class AddSourceToPitStatlines < ActiveRecord::Migration
  def change
    add_column :pit_statlines, :source, :boolean
  end
end
