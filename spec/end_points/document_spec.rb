require 'spec_helper'

describe DotloopApi::EndPoints::Document do
  subject { described_class.new(client: client, profile_id: 47, loop_id: 74, folder_id: 88) }
  let(:client) { double('client') }
  it { expect(subject).to respond_to(:all) }
  it { expect(subject).to_not respond_to(:batch) }
  it { expect(subject).to respond_to(:find) }
  it { expect(subject).to respond_to(:save) }
  it { expect(subject).to_not respond_to(:create) }
  it { expect(subject).to_not respond_to(:delete) }
  it { expect(subject.path).to eq('/profile/47/loop/74/folder/88/document') }
  it { expect(subject.type).to eq(DotloopApi::Models::Profile::Loop::Folder::Document) }

  it 'downloads' do
    expect(client).to receive(:download).with('/profile/47/loop/74/folder/88/document/1337') { :binary_string }
    expect(subject.download(id: 1337)).to eq :binary_string
  end
end
