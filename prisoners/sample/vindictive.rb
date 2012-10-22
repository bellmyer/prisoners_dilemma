require_relative '../../lib/prisoner'

module Sample
  class Vindictive < Prisoner
    attr_reader :betrayed
  
    def initialize
      @betrayed = false
    end
  
    def opponent_move= opponent_move
      @betrayed = true if opponent_move == :betray
    end
  
    def move
      betrayed ? :betray : :cooperate
    end
  end
end