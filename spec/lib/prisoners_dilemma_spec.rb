require_relative '../spec_helper'

describe PrisonersDilemma do
  let(:target) { PrisonersDilemma }

  let(:prisoner1) { Prisoner.new }
  let(:prisoner2) { Prisoner.new }
  let(:turns) { 5 }
  
  describe "opponents" do
    subject { target.new(prisoner1, prisoner2, turns).opponents }
    
    it { should be_an(Array) }
    specify { subject.size.should == 2 }

    it { should include(prisoner1) }
    it { should include(prisoner2) }
  end
  
  describe "turn_count" do
    subject { target.new(prisoner1, prisoner2, turns).turn_count }
    it { should == turns }
  end
end