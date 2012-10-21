require_relative '../spec_helper'

describe Player do
  let(:target) { Player }
  
  let(:player) { Player.new prisoner }
  let(:prisoner) { Prisoner.new }
  
  describe "initialization" do
    describe "#prisoner" do
      subject { player.prisoner }
      it { should == prisoner }
    end
    
    describe "#score" do
      subject { player.score }
      it { should == 0 }
    end
  end
  
  describe "#move" do
    it "calls prisoner's move" do
      prisoner.expects(:move).returns(:nonsense)
      player.move.should == :nonsense
    end
  end
  
  describe "#opponent_move=" do
    it "sends opponent's move to prisoner" do
      prisoner.expects(:opponent_move=).with(:cooperate)
      player.opponent_move = :cooperate
    end
  end
  
  describe "#name" do
    let(:nickname) { 'bob' }
    it "calls prisoner's class nickname" do
      prisoner.class.expects(:nickname).returns(nickname)
      player.nickname.should == nickname
    end
  end
end