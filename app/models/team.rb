class Team < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :bats
  has_many :pits
  
  def starters
    self.pits.where(reliever: false)
  end
  
  def relievers
    self.pits.where(reliever: true)
  end
end