require_relative 'prisoner'

class PrisonersDilemma
  attr_accessor :opponents, :turn_count
  
  def initialize opponent1, opponent2, turn_count
    self.opponents = [opponent1, opponent2]
    self.turn_count = turn_count
  end
end