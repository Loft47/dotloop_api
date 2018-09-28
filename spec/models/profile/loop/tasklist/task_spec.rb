require 'spec_helper'

describe DotloopApi::Models::Profile::Loop::TaskList::Task do
  it { expect(subject.attributes.keys).to match_array(%i[due id name]) }
end
