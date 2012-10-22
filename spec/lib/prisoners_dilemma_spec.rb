require_relative '../spec_helper'

describe PrisonersDilemma do
  let(:target) { PrisonersDilemma }

  let(:game) { target.new([prisoner1, prisoner2], options) }
  let(:options) { {} }
  
  let(:prisoner1) { Prisoner.new }
  let(:prisoner2) { Prisoner.new }
  let(:turns) { 80 }
  let(:default_turns) { 100 }
  
  describe "initialization" do
    before { target.any_instance.expects(:announce_players) }
    
    describe "players/prisoners" do
      subject { game.players.map(&:prisoner) }

      it { should be_an(Array) }
      specify { subject.size.should == 2 }

      it { should include(prisoner1) }
      it { should include(prisoner2) }
    end

    describe "turns" do
      subject { game.turns }

      describe "when not specified" do
        it { should == default_turns }
      end
      
      describe "when specified" do
        let(:options) { {:turns => turns} }
        it { should == turns }
      end
    end
    
    describe "turn_count" do
      subject { game.turn_count }
      it { should == 0 }
    end
    
    describe "verbose" do
      subject { game.verbose }

      describe "when not specified" do
        it { should be_true }
      end
      
      describe "when specified" do
        let(:options) { {:verbose => false} }
        it { should be_false }
      end
    end
  end
  
  describe "#announce_players" do
    describe "when verbose mode is on" do
      let(:options) { {:verbose => true} }

      it "prints the announcement" do
        $stdout.expects(:puts).with("\nPrisoner vs Prisoner")
        game
      end
    end
    
    describe "when verbose mode is off" do
      let(:options) { {:verbose => false} }

      it "does NOT print the announcement" do
        $stdout.expects(:puts).with("\nPrisoner vs Prisoner").never
        game
      end
    end
  end
  
  describe "announce_player_moves" do
    let(:move1) { :betray }
    let(:move2) { :cooperate }
    
    before do
      target.any_instance.stubs(:announce_players)
      game.stubs(:moves).returns([move1, move2])
    end
    
    describe "when verbose mode is on" do
      let(:options) { {:verbose => true} }
    
      it "prints the players' moves" do
        $stdout.expects(:puts).with("#{move1}, #{move2}")
        game.announce_player_moves
      end
    end
    
    describe "when verbose mode is off" do
      let(:options) { {:verbose => false} }
    
      it "does NOT print the players' moves" do
        $stdout.expects(:puts).with("#{move1}, #{move2}").never
        game.announce_player_moves
      end
    end
  end
  
  describe "#turn" do
    let(:turns) { default_turns }
    
    before do
      target.any_instance.stubs(:announce_players)
      
      game.expects(:announce_player_moves)
      
      prisoner1.expects(:move).returns(prisoner1_move)
      prisoner2.expects(:move).returns(prisoner2_move)
      
      prisoner1.expects(:opponent_move=).with(prisoner2_move)
      prisoner2.expects(:opponent_move=).with(prisoner1_move)
      
      game.turn
    end
    
    describe "when player1 cooperates" do
      let(:prisoner1_move) { :cooperate }

      describe "and player2 cooperates" do
        let(:prisoner2_move) { :cooperate }

        specify { game.players[0].score.should == 2 }
        specify { game.players[1].score.should == 2 }
      end
      
      describe "and player2 betrays" do
        let(:prisoner2_move) { :betray }
        
        specify { game.players[0].score.should == 5 }
        specify { game.players[1].score.should == 0 }
      end
    end
    
    describe "when player1 betrays" do
      let(:prisoner1_move) { :betray }

      describe "and player2 cooperates" do
        let(:prisoner2_move) { :cooperate }

        specify { game.players[0].score.should == 0 }
        specify { game.players[1].score.should == 5 }
      end
      
      describe "and player2 betrays" do
        let(:prisoner2_move) { :betray }
        
        specify { game.players[0].score.should == 4 }
        specify { game.players[1].score.should == 4 }
      end
    end
    
    describe "when player1 returns an invalid move" do
      let(:prisoner1_move) { :nonsense }
      let(:prisoner2_move) { :cooperate }
      
      specify { game.players[0].score.should == target::PENALTY }
      specify { game.players[1].score.should == target::PENALTY }
    end
    
    describe "when player2 returns an invalid move" do
      let(:prisoner1_move) { :cooperate }
      let(:prisoner2_move) { :nonsense }
      
      specify { game.players[0].score.should == target::PENALTY }
      specify { game.players[1].score.should == target::PENALTY }
    end
    
    describe "when both players returna n invalid move" do
      let(:prisoner1_move) { :nonsense }
      let(:prisoner2_move) { :nonsense }
      
      specify { game.players[0].score.should == target::PENALTY }
      specify { game.players[1].score.should == target::PENALTY }
    end
  end
  
  describe "#game_over?" do
    let(:turns) { default_turns }
    
    subject { game.game_over? }
    
    before do
      target.any_instance.stubs(:announce_players)
      game.stubs(:announce_player_moves)
      
      turn_count.times { game.turn }
    end
    
    describe "when the number of max turns has not been reached" do
      let(:turn_count) { turns - 1 }
      it { should be_false }
    end
    
    describe "when number of max turns has been reached" do
      let(:turn_count) { turns }
      it { should be_true }
    end
    
    describe "when number of max turns has been exceeded" do
      let(:turn_count) { turns + 1 }
      it { should be_true }
    end
  end
  
  describe "#play" do
    
  end
  
  describe "#reset" do
    before do
      target.any_instance.stubs(:announce_players)
      game.stubs(:announce_player_moves)
      
      2.times { game.turn }
      game.reset
    end
    
    specify { game.players[0].score.should == 0 }
    specify { game.players[1].score.should == 0 }
    specify { game.turn_count.should == 0 }
  end
  
  describe "scores" do
    let(:score1) { 11 }
    let(:score2) { 22 }
    
    subject { game.scores }
    
    before do
      target.any_instance.stubs(:announce_players)
      
      game.players[0].score = score1
      game.players[1].score = score2
    end
    
    it { should == [score1, score2] }
  end
end