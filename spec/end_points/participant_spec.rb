require 'spec_helper'

describe DotloopApi::EndPoints::Participant do
  subject { described_class.new(client:, profile_id: 47, loop_id: 74) }
  let(:client) { double('client') }
  let(:result) do
    {
      data: [
        {
          'id' => 1337,
          'Street Name' => 'home street',
          'role' => 'BUYER'
        }
      ]

    }
  end
  it { expect(subject).to respond_to(:all) }
  it { expect(subject).to_not respond_to(:batch) }
  it { expect(subject).to respond_to(:find) }
  it { expect(subject).to respond_to(:save) }
  it { expect(subject).to respond_to(:create) }
  it { expect(subject).to respond_to(:delete) }
  it { expect(subject.path).to eq('/profile/47/loop/74/participant') }
  it { expect(subject.type).to eq(DotloopApi::Models::Profile::Loop::Participant) }
  it '#all' do
    expect(client).to receive(:get).and_return(result)
    expect(subject.all.first).to include(street_name: 'home street')
  end
end
