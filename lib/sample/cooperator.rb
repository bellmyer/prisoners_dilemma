require_relative '../../lib/prisoner'

module Sample
  class Cooperator < Prisoner
    def move
      :cooperate
    end
  end
end