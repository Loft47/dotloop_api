require 'spec_helper'

describe DotloopApi::EndPoints::Base do
  subject { described_class.new(client:, path:, type:) }
  let(:client) { double('Client') }
  let(:path) { '/tmp' }
  let(:type) { DotloopApi::Models::Contact }
  let(:all_data) { { data: [raw_contact1, raw_contact2] } }
  let(:find_data) { { data: raw_contact1 } }
  let(:raw_contact1) { { email: 'test1@example.com', first_name: 'Bob', last_name: 'Smith', id: 101 } }
  let(:raw_contact2) { { email: 'test2@example.com', first_name: 'Barb', last_name: 'Smith', id: 102 } }
  let(:contact) { type.new(raw_contact1) }

  describe '#all' do
    it 'requests all items from an endpoint' do
      expect(client).to receive(:get).with(path).and_return(all_data)
      result = subject.all
      expect(result).to all(be_a(type))
      expect(result.first.email).to eq('test1@example.com')
    end
  end

  describe '#find' do
    it 'finds a single resource from an endpoint' do
      expect(client).to receive(:get).with('/tmp/101').and_return(find_data)
      result = subject.find(id: 101)
      expect(result).to be_a(type)
      expect(result.email).to eq('test1@example.com')
    end
  end

  describe 'save' do
    it 'saves an existing resource' do
      changed_contact = type.new(email: 'original@example.com', first_name: 'Bob', last_name: 'Smith', id: 101)
      changed_contact.email = 'test1@example.com'
      expect(client).to receive(:patch).with('/tmp/101', changed_contact).and_return(find_data)
      expect(subject.save(changed_contact).email).to eq('test1@example.com')
    end

    it 'creates a new resource when the resource is new' do
      new_contact = type.new(email: 'test1@example.com', first_name: 'Bob', last_name: 'Smith')
      expect(client).to receive(:post).with('/tmp', new_contact).and_return(find_data)
      expect(subject.save(new_contact).id).to eq(101)
    end
  end

  describe 'create' do
    it 'creates a new resource' do
      new_contact = type.new(email: 'test1@example.com', first_name: 'Bob', last_name: 'Smith')
      expect(client).to receive(:post).with('/tmp', new_contact).and_return(find_data)
      expect(subject.save(new_contact).id).to eq(101)
    end
  end

  describe 'delete' do
    it 'removes a resource' do
      expect(client).to receive(:delete).with('/tmp/101')
      subject.delete(contact)
    end
  end

  describe 'single_path' do
    it { expect(subject.single_path(99)).to eq('/tmp/99') }
  end
end
