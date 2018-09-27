module DotloopApi
  module EndPoints
    class Account
      def initialize(client:)
        @client = client
      end

      def find
        build_model(@client.get('/account')[:data])
      end

      private

      def build_model(attrs)
        DotloopApi::Models::Contact.new(attrs)
      end
    end
  end
end
