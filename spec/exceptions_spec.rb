require 'spec_helper'

describe DotloopApi do
  it 'defines errors' do
    expect(DotloopApi::BadRequest.new).to be_a StandardError
    expect(DotloopApi::Forbidden.new).to be_a StandardError
    expect(DotloopApi::MissingRefreshToken.new).to be_a StandardError
    expect(DotloopApi::MissingRevokeToken.new).to be_a StandardError
    expect(DotloopApi::NotFound.new).to be_a StandardError
    expect(DotloopApi::NotImplemented.new).to be_a StandardError
    expect(DotloopApi::TooManyRequests.new).to be_a StandardError
    expect(DotloopApi::Unauthorized.new).to be_a StandardError
    expect(DotloopApi::UnmatchState.new).to be_a StandardError
    expect(DotloopApi::UnprocessableEntity.new).to be_a StandardError
  end

  describe 'CodeMap' do
    it 'maps http response codes' do
      expect(DotloopApi::CodeMap.call(200)).to be_nil
      expect(DotloopApi::CodeMap.call(400).new).to be_a DotloopApi::BadRequest
      expect(DotloopApi::CodeMap.call(401).new).to be_a DotloopApi::Unauthorized
      expect(DotloopApi::CodeMap.call(403).new).to be_a DotloopApi::Forbidden
      expect(DotloopApi::CodeMap.call(404).new).to be_a DotloopApi::NotFound
      expect(DotloopApi::CodeMap.call(422).new).to be_a DotloopApi::UnprocessableEntity
      expect(DotloopApi::CodeMap.call(429).new).to be_a DotloopApi::TooManyRequests
      expect(DotloopApi::CodeMap.call(999).new).to be_a StandardError
    end
  end
end
