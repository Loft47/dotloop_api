require 'spec_helper'

describe DotloopApi::Models::Profile::Loop::TaskList do
  let(:endpoint) { double }
  it { expect(subject.attributes.keys).to match_array(%i[id name]) }
  describe '#tasks' do
    it 'finds activities' do
      expect(DotloopApi::EndPoints::Task).to receive(:new) { endpoint }
      expect(endpoint).to receive(:all)
      subject.tasks
    end
  end
end
