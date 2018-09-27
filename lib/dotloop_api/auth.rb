module DotloopApi
  class Auth
    include HTTParty
    attr_accessor :config

    def initialize(client_id:, client_secret:, redirect_uri:, redirect_on_deny: true, application: 'dotloop')
      @config = DotloopApi::Models::Config.new(
        application: application,
        client_id: client_id,
        client_secret: client_secret,
        redirect_on_deny: redirect_on_deny,
        redirect_uri: redirect_uri,
        state: SecureRandom.uuid
      )
    end

    def grant_uri
      uri = URI("#{base_uri}authorize")
      uri.query = URI.encode_www_form(grant_params)
      uri.to_s
    end

    def request(code:, state: nil)
      check_state(state)
      response = self.class.post("#{base_uri}token", query: request_params(code), headers: headers, timeout: 60)
      handle_error(response)
      @config.attributes = response.parsed_response
    end

    def request_from_url(url)
      request(parse_url_response(url))
    end

    def refresh
      check_refresh_token
      response = self.class.post("#{base_uri}token", query: refresh_params, headers: headers, timeout: 60)
      handle_error(response)
      @config.attributes = response.parsed_response
    end

    def revoke
      check_revoke_token
      params = { token: @config.access_token }
      response = self.class.post("#{base_uri}token/revoke", query: params, headers: headers, timeout: 60)
      handle_error(response)
      clear_auth
    end

    private

    def encoded_client_id
      Base64.urlsafe_encode64("#{@config.client_id}:#{@config.client_secret}")
    end

    def headers
      {
        'Content-Type': 'application/x-www-form-urlencoded',
        'User-Agent': @config.application.to_s,
        'Accept': '*/*',
        'Authorization': "Basic #{encoded_client_id}"
      }
    end

    def request_params(code)
      {
        code: code,
        grant_type: :authorization_code,
        redirect_uri: @config.redirect_uri,
        state: @config.state
      }
    end

    def refresh_params
      {
        grant_type: :refresh_token,
        refresh_token: @config.refresh_token
      }
    end

    def grant_params
      {
        client_id: @config.client_id,
        redirect_on_deny: @config.redirect_on_deny,
        redirect_uri: @config.redirect_uri,
        response_type: :code,
        state: @config.state
      }.delete_if { |_, v| v.nil? }
    end

    def check_state(state)
      raise DotloopApi::UnmatchState.new('State does ont match. Possible CSRF!') if state && state != @config.state
    end

    def check_refresh_token
      raise DotloopApi::MissingRefreshToken.new('Missing token to refresh') unless @config.access_token
    end

    def check_revoke_token
      raise DotloopApi::MissingRevokeToken.new('Missing token to revoke') unless @config.access_token
    end

    def handle_error(response)
      return if response.code == 200 || !(error_class = DotloopApi::CodeMap.call(response.code))
      raise error_class.new("Error communicating: Response code #{response.code}")
    end

    def parse_url_response(url)
      params = URI.decode_www_form(URI(url).query)
      Hash[*params.flatten].symbolize_keys
    end

    def clear_auth
      @config.attributes = { access_token: nil, token_type: nil, refresh_token: nil, expires_in: nil, scope: nil }
    end

    def base_uri
      'https://auth.dotloop.com/oauth/'
    end
  end
end
