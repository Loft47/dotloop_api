module DotloopApi
  module EndPoints
    class Activity < DotloopApi::EndPoints::Batch
      attr_accessor :profile_id, :loop_id

      undef_method :find
      undef_method :save
      undef_method :create
      undef_method :delete

      def initialize(client:, profile_id: nil, loop_id: nil)
        @profile_id = profile_id
        @loop_id = loop_id
        super(client:, path:, type: DotloopApi::Models::Profile::Loop::Activity)
      end

      def path
        "/profile/#{@profile_id}/loop/#{@loop_id}/activity"
      end
    end
  end
end
