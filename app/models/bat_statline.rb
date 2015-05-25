class BatStatline < ActiveRecord::Base
  belongs_to :bat, class_name: "Bat", foreign_key: "bat_id", inverse_of: :statlines
  
  NAMES_METHODS = {:g= => :to_i , :pa= => :to_i, :ab= => :to_i, :h=  => :to_i, :doubles= => 
                   :to_i, :triples= => :to_i, :hr= => :to_i, :r= => :to_i, :rbi= => :to_i, 
                   :bb= => :to_i, :so= => :to_i, :hbp= => :to_i, :sb= => :to_i, :cs= => :to_i, 
                   :avg= => :to_f, :obp= => :to_f, :slg= => :to_f, :ops= => :to_f, :woba= => 
                   :to_f, :fld= => :to_f, :bsr= => :to_f, :war= => :to_f, :playerid= => :to_i}
  
  def self.add_stats_for!(player, stats)
    statline = player.statlines.new
      
    stats.each_index do |idx|
      key = NAMES_METHODS.keys[idx]
      statline.send(key.to_sym, stats[idx].send(NAMES_METHODS[key]))
    end
      
    statline.save
  end
                   
  def tb
    self.singles + 2 * self.doubles + 3 * self.triples + 4 * self.hr
  end

  def singles
     self.h - self.doubles - self.triples - self.hr
  end
end
