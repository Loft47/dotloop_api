module DotloopApi
  module EndPoints
    class Loop < DotloopApi::EndPoints::Batch
      attr_accessor :profile_id
      undef_method :delete

      def initialize(client:, profile_id: nil)
        @profile_id = profile_id
        super(client: client, path: path, type: DotloopApi::Models::Profile::Loop)
      end

      def path
        "/profile/#{@profile_id}/loop"
      end
    end
  end
end
