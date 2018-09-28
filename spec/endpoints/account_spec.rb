require 'spec_helper'

describe DotloopApi::EndPoints::Account do
  subject { described_class.new(client: client) }
  let(:client) { double }
  let(:data) { { data: { 'email' => email } } }
  let(:email) { 'test@example.com' }
  describe '#find' do
    it 'finds the account' do
      expect(client).to receive(:get) { data }
      result = subject.find
      expect(result).to be_a DotloopApi::Models::Contact
      expect(result.email).to eq(email)
    end
  end
end
