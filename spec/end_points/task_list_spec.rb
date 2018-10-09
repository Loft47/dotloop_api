require 'spec_helper'

describe DotloopApi::EndPoints::TaskList do
  subject { described_class.new(client: :client, profile_id: 47, loop_id: 74) }
  it { expect(subject).to respond_to(:all) }
  it { expect(subject).to_not respond_to(:batch) }
  it { expect(subject).to respond_to(:find) }
  it { expect(subject).to_not respond_to(:save) }
  it { expect(subject).to_not respond_to(:create) }
  it { expect(subject).to_not respond_to(:delete) }
  it { expect(subject.path).to eq('/profile/47/loop/74/tasklist') }
  it { expect(subject.type).to eq(DotloopApi::Models::Profile::Loop::TaskList) }
end
