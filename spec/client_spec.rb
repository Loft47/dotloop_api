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
  describe '#get' do
    it 'calls raw and snakifies the result' do
      expect(subject).to receive(:raw) { parsed_response }
      expect(subject.get('/endpoint')).to eq parsed_response
    end
  end

  it '#patch' do
    expect(described_class).to receive(:patch) { response }
    expect(subject.patch('/endpoint', account)).to eq parsed_response
  end

  it '#post' do
    expect(described_class).to receive(:post) { response }
    expect(subject.post('/endpoint', account)).to eq parsed_response
  end

  it '#delete' do
    expect(described_class).to receive(:delete) { response }
    expect(subject.delete('/endpoint')).to eq parsed_response
  end

  context 'pdf download' do
    let(:response) { double(code: 200, body: :binary_string) }
    let(:headers) do
      { 'Accept' => 'application/pdf', 'Authorization' => "Bearer #{access_token}", 'User-Agent' => 'dotloop' }
    end
    it '#download' do
      expect(described_class).to receive(:get).with(
        '/endpoint',
        query: {},
        headers: headers,
        timeout: 360
      ).and_return(response)
      expect(subject.download('/endpoint')).to eq :binary_string
    end
  end

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

  context 'snakify array' do
    let(:parsed_response) { [{ fooBar: 10 }, { snakeCase: 22 }] }
    it 'snake_cases' do
      expect(described_class.snakify(parsed_response)).to eq(
        [{ foo_bar: 10 }, { snake_case: 22 }]
      )
    end
  end
end
