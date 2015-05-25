class Team < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :bats
  has_many :pits
end