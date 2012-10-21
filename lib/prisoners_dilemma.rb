require_relative 'prisoner'

class PrisonersDilemma
  attr_accessor :players, :max_years, :moves
  
  def initialize prisoners, options = {}
    config = {:max_years => 100}.merge(options)
    
    self.players = prisoners.map{ |prisoner| Player.new(prisoner) }
    self.max_years = config[:max_years]
  end
  
  def turn
    self.moves = players.map(&:move)

    notify_player_moves
    
    return unless moves_valid?
    
    calculate_scores
  end
  
  def game_over?
    players.any?{ |player| player.score >= max_years }
  end
  
  private
  
  def calculate_scores
    if all_cooperated?
      set_scores 2, 2
    elsif all_betrayed?
      set_scores 4, 4
    elsif moves[0] == :betray
      set_scores 0, 5
    elsif moves[1] == :betray
      set_scores 5, 0
    end
  end
  
  def all_cooperated?
    moves.all?{ |move| move == :cooperate }
  end
  
  def all_betrayed?
    moves.all?{ |move| move == :betray }
  end
  
  def set_scores *scores
    players[0].score += scores[0]
    players[1].score += scores[1]
  end
  
  def notify_player_moves
    players[0].opponent_move = moves[1]
    players[1].opponent_move = moves[0]
  end
  
  def moves_valid?
    players[0].score += max_years if invalid_move?(moves[0])
    players[1].score += max_years if invalid_move?(moves[1])
      
    !players.map(&:score).any?{ |score| score >= max_years }
  end
  
  def invalid_move? move
    ![:cooperate, :betray].include?(move)
  end
end