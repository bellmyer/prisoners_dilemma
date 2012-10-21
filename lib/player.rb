class Player
  attr_reader :prisoner
  attr_accessor :score
  
  def initialize prisoner
    @prisoner = prisoner
    @score = 0
  end
  
  def move
    prisoner.move
  end
  
  def opponent_move= opponent_move
    prisoner.opponent_move = opponent_move
  end
end