require_relative '../spec_helper'

describe PrisonersDilemma do
  let(:target) { PrisonersDilemma }

  let(:prisoner1) { Prisoner.new }
  let(:prisoner2) { Prisoner.new }
  let(:max_years) { 80 }
  
  describe "initialization" do
    describe "#opponents" do
      subject { target.new(prisoner1, prisoner2, max_years).opponents }

      it { should be_an(Array) }
      specify { subject.size.should == 2 }

      it { should include(prisoner1) }
      it { should include(prisoner2) }
    end

    describe "#max_years" do
      subject { target.new(prisoner1, prisoner2, max_years).max_years }
      it { should == max_years }
    end
  end
  
  describe "#play" do
    
  end
end