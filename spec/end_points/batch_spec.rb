require 'spec_helper'

describe DotloopApi::EndPoints::Batch do
  subject { described_class.new(client:, path:, type:) }
  let(:client) { double('Client') }
  let(:path) { '/tmp' }
  let(:type) { DotloopApi::Models::Contact }
  let(:all_data) { { data: [raw_contact1, raw_contact2] } }
  let(:some_data) { { data: [raw_contact3] } }
  let(:raw_contact1) { { email: 'test1@example.com', first_name: 'Bob', last_name: 'Smith', id: 101 } }
  let(:raw_contact2) { { email: 'test2@example.com', first_name: 'Barb', last_name: 'Smith', id: 102 } }
  let(:raw_contact3) { { email: 'test3@example.com', first_name: 'Sam', last_name: 'Smith', id: 103 } }
  let(:contact) { type.new(raw_contact1) }
  let(:options) { { batch_number: 1, batch_size: 2, sort_key: 'address' } }
  let(:params) { { batch_number: 1, batch_size: 2, include_details: false, sort: 'address:asc' } }

  describe '#batch' do
    it 'requests one batch or page of data from the endpoint' do
      expect(client).to receive(:get).with(path, params).and_return(all_data)
      result = subject.batch(options)
      expect(result).to all(be_a(type))
      expect(result.first.email).to eq('test1@example.com')
    end
  end

  describe '#all' do
    it 'only calls one batch' do
      expect(client).to receive(:get).with(path, params).and_return(all_data)
      subject.all(options)
    end

    context 'multiple gets' do
      let(:options) { { batch_size: 2 } }
      let(:batch1) { { batch_number: 1, batch_size: 2, include_details: false } }
      let(:batch2) { { batch_number: 2, batch_size: 2, include_details: false } }

      it 'loops until all data is returned' do
        expect(client).to receive(:get).with(path, batch1).and_return(all_data)
        expect(client).to receive(:get).with(path, batch2).and_return(some_data)
        expect(subject.all(options).size).to eq(3)
      end
    end
  end
end
