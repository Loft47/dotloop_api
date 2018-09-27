module DotloopApi
  module EndPoints
    class Profile < DotloopApi::EndPoints::Base
      undef_method :delete
      def initialize(client:)
        super(client: client, path: '/profile', type: DotloopApi::Models::Profile)
      end
    end
  end
end
