class Team < ActiveRecord::Base
  validates :name, presence: true

  has_many :game_snapshots, class_name: "Competitor",
                            foreign_key: "team_id",
                            inverse_of: :team
  has_many :bats
  has_many :pits

  def starters
    self.pits.where(reliever: false)
  end

  def relievers
    self.pits.where(reliever: true)
  end
end
