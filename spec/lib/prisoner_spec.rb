require_relative '../spec_helper'
require_relative '../../lib/prisoner'

describe Prisoner do
  let(:target) { Prisoner }
  
  it { should be_an_instance_of(target) }
end