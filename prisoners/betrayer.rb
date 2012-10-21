require_relative '../lib/prisoner'

class Betrayer < Prisoner
  def move
    :betray
  end
end
