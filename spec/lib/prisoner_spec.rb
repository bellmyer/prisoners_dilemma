require_relative '../spec_helper'

describe Prisoner do
  let(:target) { Prisoner }
  
  it { should be_an_instance_of(target) }
  
  describe "#opponent_move=" do
    it "accepts the opponent's move" do
      lambda{ subject.opponent_move = :cooperate }.should_not raise_error
    end
  end
  
  describe "move" do
    subject { target.new.move }
    
    it "should be either :cooperate or :betray" do
      [:cooperate, :betray].should include(subject)
    end
  end
end