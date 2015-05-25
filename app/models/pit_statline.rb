class PitStatline < ActiveRecord::Base
  belongs_to :pit, inverse_of: :statlines
  
  NAMES_METHODS = {:w= => :to_i, :l= => :to_i, :era= => :to_f,
    :gs= => :to_i, :g= => :to_i, :ip= => :to_f, :h= => :to_i,
    :er= => :to_i, :hr= => :to_i, :so= => :to_i, :bb= => :to_i,
    :whip= => :to_f, :k_per_9= => :to_f, :bb_per_9= => :to_f,
    :fip= => :to_f, :war= => :to_f}
    
  def self.add_stats_for!(player, stats, source)
    statline = player.statlines.new
    
    statline.source = source == "uzips" ? true : false
    
    stats.each_index do |idx|
      key = NAMES_METHODS.keys[idx]
      statline.send(key, stats[idx].send(NAMES_METHODS[key]))
    end
    
    statline.save
  end
end
