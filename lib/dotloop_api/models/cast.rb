module DotloopApi
  module Models
    module Cast
      def cast(attribute:, klass:)
        return if attribute.nil? || attribute.empty?
        attribute = klass klass.new(attribute) unless attribute.instance_of?(klass)
        attribute.normalize if attribute.responds_to(:normalize)
      end
    end
  end
end
