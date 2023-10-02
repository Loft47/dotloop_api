module DotloopApi
  module EndPoints
    class TaskList < DotloopApi::EndPoints::Base
      attr_accessor :profile_id, :loop_id

      undef_method :save
      undef_method :create
      undef_method :delete

      def initialize(client:, profile_id: nil, loop_id: nil)
        @profile_id = profile_id
        @loop_id = loop_id
        super(client:, path:, type: DotloopApi::Models::Profile::Loop::TaskList)
      end

      def path
        "/profile/#{@profile_id}/loop/#{@loop_id}/tasklist"
      end
    end
  end
end
