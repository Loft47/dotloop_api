module DotloopApi
  class Client
    include HTTParty
    require 'active_support/all'
    base_uri 'https://api-gateway.dotloop.com/public/v2/'

    attr_accessor :access_token, :application, :limit, :limit_remaining, :limit_reset

    def initialize(access_token:, application: 'dotloop')
      @access_token = access_token
      @application = application
      @limit = 100
      @limit_remaining = 100
      @limit_reset = 0
    end

    def get(page, params = {})
      response = raw(page, params)
      self.class.snakify(response)
    end

    def patch(page, model)
      response = self.class.patch(page, query: model.attributes, headers: headers, timeout: 60)
      limits_from_headers(response.headers)
      handle_dotloop_error(response.code) if response.code != 200
      self.class.snakify(response.parsed_response)
    end

    def post(page, model)
      response = self.class.post(page, query: model.attributes, headers: headers, timeout: 60)
      limits_from_headers(response.headers)
      handle_dotloop_error(response.code) if response.code != 200
      self.class.snakify(response.parsed_response)
    end

    def delete(page)
      response = self.class.delete(page, headers: headers, timeout: 60)
      limits_from_headers(response.headers)
      handle_dotloop_error(response.code) if response.code != 200
      self.class.snakify(response.parsed_response)
    end

    def raw(page, params = {})
      response = self.class.get(page, query: params, headers: headers, timeout: 60)
      limits_from_headers(response.headers)
      handle_dotloop_error(response.code) if response.code != 200
      response.parsed_response
    end

    def download(page, params = {})
      response = self.class.get(page, query: params, headers: download_headers, timeout: 360)
      handle_dotloop_error(response.code) if response.code != 200
      response.body
    end

    def handle_dotloop_error(code)
      return unless (error_class = DotloopApi::CodeMap.call(code))
      raise error_class.new "Error communicating: Response code #{code}"
    end

    def account
      @account ||= DotloopApi::EndPoints::Account.new(client: self).find
    end

    def Profile # rubocop:disable Naming/MethodName
      @Profile ||= DotloopApi::EndPoints::Profile.new(client: self) # rubocop:disable Naming/VariableName
    end

    def Contact # rubocop:disable Naming/MethodName
      @Contact ||= DotloopApi::EndPoints::Contact.new(client: self) # rubocop:disable Naming/VariableName
    end

    def self.snakify(hash)
      if hash.is_a? Array
        hash.map { |item| item.to_snake_keys.symbolize_keys }
      else
        hash.to_snake_keys.symbolize_keys
      end
    end

    private

    def limits_from_headers(headers)
      @limit = headers['X-RateLimit-Limit']
      @limit_remaining = headers['X-RateLimit-Remaining']
      @limit_reset = headers['X-RateLimit-Reset']
    end

    def download_headers
      headers.merge('Accept' => 'application/pdf')
    end

    def headers
      {
        'Authorization' => "Bearer #{@access_token}",
        'User-Agent' => @application,
        'Accept' => '*/*'
      }
    end
  end
end
