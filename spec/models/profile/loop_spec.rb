require 'spec_helper'

describe DotloopApi::Models::Profile::Loop do
  let(:endpoint) { double }
  it 'has attributes' do
    expect(subject.attributes.keys).to match_array(
      %i[
        completed_task_count created id loop_url name owner_profile_id profile_id status total_task_count
        transaction_type updated details all_participants
      ]
    )
  end

  describe '#activities' do
    it 'finds activities' do
      expect(DotloopApi::EndPoints::Activity).to receive(:new) { endpoint }
      expect(endpoint).to receive(:all)
      subject.activities
    end
  end

  describe '#detail' do
    it 'finds detail' do
      expect(DotloopApi::EndPoints::Detail).to receive(:new) { endpoint }
      expect(endpoint).to receive(:find)
      subject.detail
    end
  end

  describe '#folders' do
    it 'finds folders' do
      expect(DotloopApi::EndPoints::Folder).to receive(:new) { endpoint }
      expect(endpoint).to receive(:all)
      subject.folders
    end
  end

  describe '#participants' do
    it 'finds participants' do
      expect(DotloopApi::EndPoints::Participant).to receive(:new) { endpoint }
      expect(endpoint).to receive(:all)
      subject.participants
    end
  end

  describe '#task_lists' do
    it 'finds folders' do
      expect(DotloopApi::EndPoints::TaskList).to receive(:new) { endpoint }
      expect(endpoint).to receive(:all)
      subject.task_lists
    end
  end
end
