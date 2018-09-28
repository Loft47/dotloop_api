require 'spec_helper'

describe DotloopApi::Models::Profile::Loop::Folder::Document do
  let(:endpoint) { double }
  it { expect(subject.attributes.keys).to match_array(%i[created id name updated]) }

  describe '#download' do
    it 'can find a loop' do
      expect(DotloopApi::EndPoints::Document).to receive(:new) { endpoint }
      expect(endpoint).to receive(:download)
      subject.download
    end
  end
end
