require 'spec_helper'

describe DotloopApi::EndPoints::Detail do
  subject { described_class.new(client: client, profile_id: 47, loop_id: 74) }
  let(:client) { double('client') }
  let(:result) do
    {
      data: {
        'Property Address' => { 'Country' => 'USA' },
        'Listing Information' => { 'Current PRice' => '100' }
      }
    }
  end
  it { expect(subject).to_not respond_to(:all) }
  it { expect(subject).to_not respond_to(:batch) }
  it { expect(subject).to respond_to(:find) }
  it { expect(subject).to respond_to(:save) }
  it { expect(subject).to_not respond_to(:create) }
  it { expect(subject).to_not respond_to(:delete) }
  it { expect(subject.path).to eq('/profile/47/loop/74/detail') }
  it { expect(subject.type).to eq(DotloopApi::Models::Profile::Loop::Detail) }
  it '#find' do
    expect(client).to receive(:get).and_return(result)
    expect(subject.find.listing_information).to include(current_price: '100')
  end
end
