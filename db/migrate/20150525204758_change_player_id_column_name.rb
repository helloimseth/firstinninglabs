class ChangePlayerIdColumnName < ActiveRecord::Migration
  def change
    rename_column :bats, :playerid, :mlb_player_id
  end
end
