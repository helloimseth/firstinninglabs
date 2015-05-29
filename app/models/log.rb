class Log < ActiveRecord::Base
  has_many :games, class_name: "Game", foreign_key: :log_id

  
end
