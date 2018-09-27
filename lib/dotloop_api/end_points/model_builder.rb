module DotloopApi
  module EndPoints
    module ModelBuilder
      def build_model(attrs)
        model = @type.new(fix_nested_attributes(attrs))
        model.client = @client if model.respond_to?(:client)
        model.profile_id = @profile_id if model.respond_to?(:profile_id)
        model.loop_id = @loop_id if model.respond_to?(:loop_id)
        model.folder_id = @folder_id if model.respond_to?(:folder_id)
        model
      end

      def build_documents(attrs)
        attrs['documents'].map do |doc_attrs|
          doc = DotloopApi::Models::Profile::Loop::Folder::Document.new(doc_attrs)
          doc.client = @client
          doc.profile_id = @profile_id
          doc.loop_id = @loop_id
          doc.folder_id = attrs['id']
          doc
        end
      end

      def build_details(attrs)
        data = fix_hash(attrs)
        data.keys.each_with_object({}) do |key, memo|
          memo[key] = detail_model(key).new(data[key])
        end
      end

      private

      def fix_nested_attributes(attrs)
        attrs['details'] = build_details(attrs['details']) if attrs.key?('details')
        attrs['documents'] = build_documents(attrs) if attrs.key?('documents')
        attrs
      end

      def fix_hash(hash)
        hash.each_with_object({}) do |(key, value), memo|
          new_key = fix_key(key)
          memo[new_key] = value.is_a?(Hash) ? fix_hash(value) : value
        end
      end

      def fix_key(index)
        index
          .to_s
          .delete("'")
          .gsub('%', 'Percent')
          .gsub('$', 'Dollar')
          .downcase
          .gsub(/[^a-z]/, '_')
          .squeeze('_')
          .gsub(/^_*/, '')
          .to_sym
      end

      def detail_model(key)
        "DotloopApi::Models::Profile::Loop::Detail::#{key.to_s.camelize}".constantize
      end
    end
  end
end
