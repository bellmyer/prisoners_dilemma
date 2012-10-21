require_relative '../lib/prisoner'

class Cooperator < Prisoner
  def move
    :cooperate
  end
end
