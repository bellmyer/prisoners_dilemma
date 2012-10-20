require_relative 'prisoner'

class PrisonersDilemma
  attr_accessor :opponents, :max_years
  
  def initialize opponent1, opponent2, max_years
    self.opponents = [opponent1, opponent2]
    self.max_years = max_years
  end
end