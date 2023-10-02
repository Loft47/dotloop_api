module DotloopApi
  module EndPoints
    class Folder < DotloopApi::EndPoints::Base
      attr_accessor :profile_id, :loop_id

      undef_method :delete

      def initialize(client:, profile_id: nil, loop_id: nil)
        @profile_id = profile_id
        @loop_id = loop_id
        super(client:, path:, type: DotloopApi::Models::Profile::Loop::Folder)
      end

      def all(options = {})
        options_to_params(options)
        @client.get(path, **@params)[:data].map { |attrs| build_model(attrs) }
      end

      def path
        "/profile/#{@profile_id}/loop/#{@loop_id}/folder"
      end

      private

      def options_to_params(options)
        @params = {
          include_documents: options.key?(:include_documents) ? options[:include_documents] : true
        }
      end
    end
  end
end
