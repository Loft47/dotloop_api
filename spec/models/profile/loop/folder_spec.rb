require 'spec_helper'

describe DotloopApi::Models::Profile::Loop::Folder do
  let(:endpoint) { double }
  it { expect(subject.attributes.keys).to match_array(%i[name id created updated documents]) }
  describe '#document_list' do
    it 'finds documents' do
      expect(DotloopApi::EndPoints::Document).to receive(:new) { endpoint }
      expect(endpoint).to receive(:all)
      subject.document_list
    end
  end
end
