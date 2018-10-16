module DotloopApi
  module Models
    class Config
      include Virtus.model
      attribute :access_token
      attribute :application, String, default: 'dotloop'
      attribute :client_id, String, required: true
      attribute :client_secret, String, required: true
      attribute :expires_in
      attribute :redirect_on_deny, Boolean, default: true
      attribute :redirect_uri, String
      attribute :refresh_token
      attribute :scope, String
      attribute :state, String
      attribute :token_type, String
    end
  end
end
