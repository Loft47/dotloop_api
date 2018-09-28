require 'spec_helper'

describe DotloopApi::Models::Config do
  it 'has attributes' do
    expect(subject.attributes.keys).to match_array(
      %i[
        access_token application client_id client_secret expires_in redirect_on_deny
        redirect_uri refresh_token scope state token_type
      ]
    )
  end
end
