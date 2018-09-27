module DotloopApi
  module EndPoints
    class Base
      include DotloopApi::EndPoints::ModelBuilder
      include Virtus.model
      attribute :client
      attribute :path
      attribute :type
      def all
        @client.get(path)[:data].map { |attrs| build_model(attrs) }
      end

      def find(id:)
        build_model(@client.get(single_path(id))[:data])
      end

      def save(model)
        return create(model) unless model.id
        response = @client.patch(single_path(model.id), model)
        handle_error(response)
        build_model(response[:data])
      end

      def create(model)
        response = @client.post(path, model)
        handle_error(response)
        build_model(response[:data])
      end

      def delete(model)
        response = @client.delete(single_path(model.id))
        handle_error(response)
        model
      end

      def single_path(id)
        [path, '/', id.to_i].join
      end
    end
  end
end
