require 'spec_helper'

describe DotloopApi::Models::Profile::Loop::Activity do
  it { expect(subject.attributes.keys).to match_array(%i[date message]) }
end
