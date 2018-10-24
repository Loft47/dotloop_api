module DotloopApi
  module EndPoints
    class Document < DotloopApi::EndPoints::Base
      attr_accessor :profile_id
      attr_accessor :loop_id
      attr_accessor :folder_id
      undef_method :create
      undef_method :delete
      def initialize(client:, profile_id: nil, loop_id: nil, folder_id: nil)
        @profile_id = profile_id
        @loop_id = loop_id
        @folder_id = folder_id
        super(client: client, path: path, type: DotloopApi::Models::Profile::Loop::Folder::Document)
      end

      def path
        "/profile/#{@profile_id}/loop/#{@loop_id}/folder/#{@folder_id}/document"
      end

      def download(id:)
        @client.download(single_path(id))
      end
    end
  end
end
