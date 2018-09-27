module DotloopApi
  module EndPoints
    class Detail < DotloopApi::EndPoints::Base
      attr_accessor :profile_id
      attr_accessor :loop_id
      def initialize(client:, profile_id: nil, loop_id: nil)
        @profile_id = profile_id
        @loop_id = loop_id
        super(client: client, path: path, type: DotloopApi::Models::Profile::Loop::Detail)
      end

      def find
        build_model(@client.get(path)[:data])
      end

      def path
        "/profile/#{@profile_id}/loop/#{@loop_id}/detail"
      end

      def build_model(attrs)
        super(build_details(attrs))
      end
    end
  end
end
