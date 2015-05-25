class PitStatline < ActiveRecord::Base
  belongs_to :pit, inverse_of :statline
end
