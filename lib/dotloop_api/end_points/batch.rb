module DotloopApi
  module EndPoints
    class Batch < DotloopApi::EndPoints::Base
      MAX_LOOPS = 500
      def all(options = {})
        options_to_params(options)
        return batch(options) if @params[:batch_number]
        loop_over_all_batches
      end

      def batch(options = {})
        options_to_params(options)
        @client.get(path, @params)[:data].map { |attrs| build_model(attrs) }
      end

      private

      def options_to_params(options)
        @params = DotloopApi::EndPoints::ParamHelper.new(options).params
      end

      def loop_over_all_batches
        collection = []
        (1..MAX_LOOPS).each do |i|
          @params.batch_number = i
          current_batch = batch(@params.attributes)
          collection += current_batch
          break if current_batch.size <= @params.batch_size
        end
        collection
      end
    end
  end
end
