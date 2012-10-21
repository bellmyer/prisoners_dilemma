require_relative '../lib/prisoner'

class TitForTat < Prisoner
  attr_reader :opponent_move
  
  def opponent_move= opponent_move
    @opponent_move = opponent_move
  end
  
  def move
    opponent_move || :cooperate
  end
end

TitForTat