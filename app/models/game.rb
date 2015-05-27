class Game < ActiveRecord::Base
  belongs_to :favorite, class_name: "Competitor", foreign_key: "favorite_id"
  belongs_to :underdog, class_name: "Competitor", foreign_key: "underdog_id"
end
