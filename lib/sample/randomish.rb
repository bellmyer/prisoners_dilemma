require_relative '../../lib/prisoner'

module Sample
  class Randomish < Prisoner
    def move
      [:cooperate, :betray].shuffle.first
    end
  end
end