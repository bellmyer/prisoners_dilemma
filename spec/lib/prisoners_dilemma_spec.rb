require_relative '../spec_helper'

describe PrisonersDilemma do
  let(:target) { PrisonersDilemma }

  let(:game) { target.new([prisoner1, prisoner2]) }
  let(:game_with_max_years) { target.new([prisoner1, prisoner2], :max_years => max_years) }
  
  let(:prisoner1) { Prisoner.new }
  let(:prisoner2) { Prisoner.new }
  let(:max_years) { 80 }
  let(:default_max_years) { 100 }
  
  describe "initialization" do
    describe "players/prisoners" do
      subject { game.players.map(&:prisoner) }

      it { should be_an(Array) }
      specify { subject.size.should == 2 }

      it { should include(prisoner1) }
      it { should include(prisoner2) }
    end

    describe "max_years" do
      describe "when not specified" do
        subject { game.max_years }
        it { should == default_max_years }
      end
      
      describe "when specified" do
        subject { game_with_max_years.max_years }
        it { should == max_years }
      end
    end
  end
  
  describe "#turn" do
    let(:max_years) { default_max_years }
    
    before do
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
      
      specify { game.players[0].score.should == max_years }
      specify { game.players[1].score.should == 0 }
    end
    
    describe "when player2 returns an invalid move" do
      let(:prisoner1_move) { :cooperate }
      let(:prisoner2_move) { :nonsense }
      
      specify { game.players[0].score.should == 0 }
      specify { game.players[1].score.should == max_years }
    end
    
    describe "when both players returna n invalid move" do
      let(:prisoner1_move) { :nonsense }
      let(:prisoner2_move) { :nonsense }
      
      specify { game.players[0].score.should == max_years }
      specify { game.players[1].score.should == max_years }
    end
  end
  
  describe "#game_over?" do
    let(:max_years) { default_max_years }
    
    subject { game.game_over? }
    
    before do
      game.players[0].stubs(:score).returns(score1)
      game.players[1].stubs(:score).returns(score2)
    end
    
    describe "when neither player has reached max years" do
      let(:score1) { max_years - 1 }
      let(:score2) { max_years - 1 }
      
      it { should be_false }
    end
    
    describe "when player1 has reached max years" do
      let(:score1) { max_years }
      let(:score2) { max_years - 1 }
      
      it { should be_true }
    end
    
    describe "when player2 has reached max years" do
      let(:score1) { max_years - 1 }
      let(:score2) { max_years }
      
      it { should be_true }
    end
    
    describe "when both players have reached max years" do
      let(:score1) { max_years }
      let(:score2) { max_years }
      
      it { should be_true }
    end
  end
  
  describe "play" do
    
  end
end