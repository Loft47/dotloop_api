require 'spec_helper'

describe DotloopApi::Models::Contact do
  it 'has attributes' do
    expect(subject.attributes.keys).to match_array(
      %i[
        address cell_phone city company_name country email fax first_name home id last_name license_number office
        phone role state state_prov street_name street_number updated zip_code zip_postal_code
      ]
    )
  end
end
