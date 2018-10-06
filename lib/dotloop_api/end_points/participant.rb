module DotloopApi
  module EndPoints
    class Participant < DotloopApi::EndPoints::Base
      attr_accessor :profile_id
      attr_accessor :loop_id

      def initialize(client:, profile_id: nil, loop_id: nil)
        @profile_id = profile_id
        @loop_id = loop_id
        super(client: client, path: path, type: DotloopApi::Models::Profile::Loop::Participant)
      end

      def path
        "/profile/#{@profile_id}/loop/#{@loop_id}/participant"
      end

      def build_model(attrs)
        super(fix_hash(attrs))
      end
    end
  end
end
