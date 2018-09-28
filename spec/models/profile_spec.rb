require 'spec_helper'

describe DotloopApi::Models::Profile do
  let(:endpoint) { double }
  it 'has attributes' do
    expect(subject.attributes.keys).to match_array(
      %i[address city company country default fax id name phone state type zipcode]
    )
  end

  describe '#loop' do
    it 'can find a loop' do
      expect(DotloopApi::EndPoints::Loop).to receive(:new) { endpoint }
      expect(endpoint).to receive(:find).with(id: 1)
      subject.loop(1)
    end
  end

  describe '#loops' do
    it 'can find loops' do
      expect(DotloopApi::EndPoints::Loop).to receive(:new) { endpoint }
      expect(endpoint).to receive(:all)
      subject.loops
    end
  end

  describe '#loop_templates' do
    it 'can find loops' do
      expect(DotloopApi::EndPoints::LoopTemplate).to receive(:new) { endpoint }
      expect(endpoint).to receive(:all)
      subject.loop_templates
    end
  end
end
