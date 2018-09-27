module DotloopApi
  module EndPoints
    class Contact < DotloopApi::EndPoints::Batch
      def initialize(client:)
        super(client: client, path: '/contact', type: DotloopApi::Models::Contact)
      end
    end
  end
end
