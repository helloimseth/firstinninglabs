class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.integer :team_id
      t.float :off_expected_war
      t.float :sp_expected_war
      t.float :rp_expected_war

      t.timestamps null: false
    end
  end
end
