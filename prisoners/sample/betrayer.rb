require_relative '../lib/prisoner'

module Sample
  class Betrayer < Prisoner
    def move
      :betray
    end
  end
end