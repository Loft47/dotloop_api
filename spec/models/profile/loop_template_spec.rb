require 'spec_helper'

describe DotloopApi::Models::Profile::LoopTemplate do
  it 'has attributes' do
    expect(subject.attributes.keys).to match_array(
      %i[id profile_id name transaction_type shared global]
    )
  end
end
