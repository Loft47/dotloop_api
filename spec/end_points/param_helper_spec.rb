require 'spec_helper'

describe DotloopApi::EndPoints::ParamHelper do
  it 'defaults' do
    expect(params).to include(batch_number: 1, batch_size: 100, include_details: false)
  end

  describe 'sort' do
    it { expect(params(sort_key: 'address', sort_direction: 'asc')).to include(sort: 'address:asc') }
    it { expect(params(sort_key: 'address', sort_direction: 'wrong')).to include(sort: 'address:desc') }
    it { expect(params(sort_key: 'wrong')).to_not include(:sort) }
  end

  describe 'filter' do
    it 'strigfies a given hash' do
      filter_hash = { transaction_type: 'PURCHASE_OFFER', transaction_status: %w[ARCHIVED ACTIVE_LISTING] }
      filter_string = 'transaction_type=PURCHASE_OFFER,transaction_status=ARCHIVED|ACTIVE_LISTING'
      expect(params(filter: filter_hash)).to include(filter: filter_string)
    end

    it 'ignores unknown filters' do
      filter_hash = { transaction_type: 'PURCHASE_OFFER', random: 123 }
      filter_string = 'transaction_type=PURCHASE_OFFER'
      expect(params(filter: filter_hash)[:filter]).to eq(filter_string)
    end
  end

  def params(options = {})
    described_class.new(options).params
  end
end
