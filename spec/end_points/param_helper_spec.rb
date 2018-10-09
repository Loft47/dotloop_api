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
    it 'only allows specific filters' do
      filter_string = 'transaction_type=PURCHASE_OFFER&other=123&transaction_status=PRE_OFFER|PRE_LISTING'
      expect(params(filter: filter_string)).to include(
        filter: {
          'transaction_type' => 'PURCHASE_OFFER',
          'transaction_status' => 'PRE_OFFER|PRE_LISTING'
        }
      )
    end
  end

  def params(options = {})
    described_class.new(options).params
  end
end
