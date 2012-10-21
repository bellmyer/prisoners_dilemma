class Prisoner
  class << self
    def nickname
      name
    end
  end
  
  def opponent_move= move
  end
  
  def move
    :cooperate
  end
end
