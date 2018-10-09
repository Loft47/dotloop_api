require 'spec_helper'

describe DotloopApi::EndPoints::Contact do
  subject { described_class.new(client: :client) }
  it { expect(subject).to respond_to(:all) }
  it { expect(subject).to respond_to(:batch) }
  it { expect(subject).to respond_to(:find) }
  it { expect(subject).to respond_to(:save) }
  it { expect(subject).to respond_to(:create) }
  it { expect(subject).to respond_to(:delete) }
  it { expect(subject.path).to eq('/contact') }
  it { expect(subject.type).to eq(DotloopApi::Models::Contact) }
end
