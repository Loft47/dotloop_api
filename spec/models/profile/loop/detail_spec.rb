require 'spec_helper'

describe DotloopApi::Models::Profile::Loop::Detail do
  let(:endpoint) { double }
  it 'has attributes' do
    expect(subject.attributes.keys).to match_array(
      %i[
        contract_dates contract_info financials geographic_description
        listing_information offer_dates property_address property referral
      ]
    )
  end

  it '#save' do
    expect(DotloopApi::EndPoints::Detail).to receive(:new) { endpoint }
    expect(endpoint).to receive(:save).with(subject)
    subject.save
  end
end
