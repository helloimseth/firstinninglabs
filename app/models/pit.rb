class Pit < ActiveRecord::Base
  belongs_to :team
  has_many :statlines, class_name: "PitStatline", 
                       foreign_key: "pit_id", inverse_of: :pit
                       
  
end
