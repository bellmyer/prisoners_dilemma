require_relative 'prisoner'

class PrisonersDilemma
  attr_accessor :players, :turns, :verbose, :moves, :turn_count
  
  PENALTY = 10
  DEFAULT_TURNS = 50

  class << self
    def run prisoner_classes, options = {}
      new(prisoner_classes.map(&:new), options).play
    end
  end
  
  def initialize prisoners, options = {}
    defaults = {:turns => DEFAULT_TURNS, :verbose => true}
    config = defaults.merge(options)
    
    self.players = prisoners.map{ |prisoner| Player.new(prisoner) }
    self.turns = config[:turns]
    self.verbose = config[:verbose]
    self.turn_count = 0
    
    announce_players
  end
  
  def turn
    self.turn_count += 1
    self.moves = players.map(&:move)

    notify_player_moves
    announce_player_moves
    
    unless moves_valid?
      penalize
      return
    end
    
    calculate_scores
    scores
  end
  
  def announce_players
    puts "\n" + players.map(&:nickname).join(' vs ') if verbose
  end
  
  def announce_player_moves
    puts moves.map(&:to_s).join(', ') if verbose
  end
  
  def scores
    players.map(&:score)
  end
  
  def play
    turn until game_over?
    players.map(&:score)
  end
  
  def reset
    players.each { |player| player.score = 0 }
    self.turn_count = 0
  end
  
  def game_over?
    turn_count >= turns
  end
  
  private
  
  def penalize
    set_scores PENALTY, PENALTY
  end
  
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
    !moves.any?{ |move| invalid_move?(move) }
  end
  
  def invalid_move? move
    ![:cooperate, :betray].include?(move)
  end
end

PD = PrisonersDilemma