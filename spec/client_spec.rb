require 'spec_helper'

describe DotloopApi::Client do
  let(:access_token) { 'cccccccc-4747-7474-b87d-ffffffffffff' }
  let(:end_point) { double('EndPoint') }
  let(:code) { 200 }
  let(:response) { double(code: code, parsed_response: parsed_response) }
  let(:parsed_response) { { some_key: 'some_value' } }
  let(:account) { DotloopApi::Models::Contact.new }
  subject { described_class.new(access_token: access_token) }

  describe '#initialize' do
    it { expect { described_class.new }.to raise_error(ArgumentError) }
    it { expect(subject.access_token).to eq access_token }
    it { expect(subject).to be_a described_class }
  end
  describe '#get'
  describe '#patch'
  describe '#post'
  describe '#delete'

  describe '#raw' do
    context 'error' do
      let(:code) { 403 }
      it 'throws an error' do
        expect(described_class).to receive(:get) { response }
        expect(subject).to receive(:handle_dotloop_error)
        subject.raw('/endpoint')
      end
    end
    it 'returns data' do
      expect(described_class).to receive(:get) { response }
      expect(subject.raw('/endpoint')).to eq parsed_response
    end
  end

  describe '#handle_dotloop_error' do
    context 'error' do
      let(:code) { 403 }
      it { expect { subject.handle_dotloop_error(code) }.to raise_error(DotloopApi::Forbidden) }
    end
    it { expect(subject.handle_dotloop_error(code)).to be_nil }
  end

  it '#account' do
    expect(DotloopApi::EndPoints::Account).to receive(:new) { end_point }
    expect(end_point).to receive(:find) { account }
    expect(subject.account).to be_a DotloopApi::Models::Contact
  end

  it { expect(subject.Profile).to be_a DotloopApi::EndPoints::Profile }
  it { expect(subject.Contact).to be_a DotloopApi::EndPoints::Contact }
end
