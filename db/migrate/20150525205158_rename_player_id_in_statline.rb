class RenamePlayerIdInStatline < ActiveRecord::Migration
  def change
    rename_column :bat_statlines, :player_id, :bat_id
  end
end
