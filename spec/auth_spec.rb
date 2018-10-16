require 'spec_helper'

describe DotloopApi::Auth do
  subject do
    described_class.new(
      client_id: '11111111-2222-3333-1111-aaaaaaaaaaaa',
      client_secret: '88888888-ffff-eeee-1111-222222222222',
      redirect_uri: 'https://www.google.com'
    )
  end
  let(:response) { double('Repsonse', code: code, parsed_response: parsed_response) }
  let(:code) { 200 }
  let(:parsed_response) { { access_token: new_access_token, refresh_token: refresh_token, expires_in: 50 } }
  let(:new_access_token) { access_token }
  let(:access_token) { :access_token }
  let(:refresh_token) { :refresh_token }

  let(:authenticated_subject) do
    subject.config.attributes = { access_token: access_token, refresh_token: refresh_token }
    subject
  end

  it '#initialize' do
    expect(subject.config).to be_a DotloopApi::Models::Config
    expect(subject.config).to include(
      client_id: '11111111-2222-3333-1111-aaaaaaaaaaaa',
      client_secret: '88888888-ffff-eeee-1111-222222222222',
      redirect_uri: 'https://www.google.com',
      application: anything,
      state: anything
    )
  end

  it { expect(subject.grant_uri).to eq expected_grant }

  describe '#request' do
    context 'errors' do
      let(:code) { 418 }
      it 'invalid state' do
        expect { subject.request(code: '123', state: 'wrong') }.to raise_error DotloopApi::UnmatchState
      end

      it 'handles errors' do
        expect(described_class).to receive(:post) { response }
        expect { subject.request(code: '123', state: subject.config.state) }.to raise_error StandardError
      end
    end

    it 'requests a token' do
      expect(described_class).to receive(:post) { response }
      subject.request(code: '123', state: subject.config.state)
      expect(subject.config).to have_attributes(
        access_token: :access_token,
        expires_in: 50,
        refresh_token: :refresh_token
      )
    end
  end

  it '#request_from_url' do
    expect(subject).to receive(:request).with(code: '123', state: '567')
    subject.request_from_url('http://do.it?code=123&state=567')
  end

  describe '#refresh' do
    context 'no token' do
      let(:access_token) { nil }
      it 'not authenticated' do
        expect { authenticated_subject.refresh }.to raise_error DotloopApi::MissingRefreshToken
      end
    end

    context 'server error' do
      let(:code) { 418 }
      it 'handles errors' do
        expect(described_class).to receive(:post) { response }
        expect { authenticated_subject.refresh }.to raise_error StandardError
      end
    end
    let(:new_access_token) { :new_access_token }

    it 'refreshs a token' do
      expect(described_class).to receive(:post) { response }
      authenticated_subject.refresh
      expect(authenticated_subject.config).to have_attributes(
        access_token: :new_access_token,
        expires_in: 50,
        refresh_token: :refresh_token
      )
    end
  end

  describe '#revoke' do
    context 'no token' do
      let(:access_token) { nil }
      it 'not authenticated' do
        expect { authenticated_subject.revoke }.to raise_error DotloopApi::MissingRevokeToken
      end
    end

    context 'server error' do
      let(:code) { 418 }
      it 'handles errors' do
        expect(described_class).to receive(:post) { response }
        expect { authenticated_subject.revoke }.to raise_error StandardError
      end
    end
    let(:new_access_token) { :new_access_token }

    it 'revokes a token' do
      expect(described_class).to receive(:post) { response }
      authenticated_subject.revoke
      expect(authenticated_subject.config).to have_attributes(access_token: nil, expires_in: nil, refresh_token: nil)
    end
  end

  def expected_grant
    "https://auth.dotloop.com/oauth/authorize?client_id=11111111-2222-3333-1111-aaaaaaaaaaaa&redirect_on_deny=true&redirect_uri=https%3A%2F%2Fwww.google.com&response_type=code&state=#{subject.config.state}"
  end
end
