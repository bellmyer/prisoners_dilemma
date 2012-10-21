require_relative '../lib/prisoner'

class Randomish < Prisoner
  def move
    [:cooperate, :betray].shuffle.first
  end
end
