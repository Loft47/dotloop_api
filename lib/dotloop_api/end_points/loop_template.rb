module DotloopApi
  module EndPoints
    class LoopTemplate < DotloopApi::EndPoints::Base
      attr_accessor :profile_id

      undef_method :save
      undef_method :create
      undef_method :delete

      def initialize(client:, profile_id: nil)
        @profile_id = profile_id
        super(client:, path:, type: DotloopApi::Models::Profile::LoopTemplate)
      end

      def path
        "/profile/#{@profile_id}/loop-template"
      end
    end
  end
end
