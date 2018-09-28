require 'spec_helper'

describe DotloopApi::Models::Contact do
  it 'has attributes' do
    expect(subject.attributes.keys).to match_array(
      %i[
        address cell_phone city country email fax first_name full_name home id last_name office role state street_name
        street_number updated zip_code zip_postal_code
      ]
    )
  end
end
