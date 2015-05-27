class AddRpspAndLinupToCompetitors < ActiveRecord::Migration
  def change
    add_column :competitors, :sp, :integer
    add_column :competitors, :rps, :integer, array: true
    add_column :competitors, :lineup, :integer, array: true
  end
end
