module DotloopApi
  module EndPoints
    class ParamHelper
      include Virtus.model
      attribute :batch_number, Integer, default: 1
      attribute :batch_size, Integer, default: 100
      attribute :filter, Hash
      attribute :include_details, Boolean, default: false
      attribute :sort_key
      attribute :sort_direction, String, default: 'asc'

      MAX_BATCH_SIZE = 100
      FILTER_OPTIONS = %w[
        updated_min created_min transaction_type transaction_status
      ].freeze

      def params
        {
          batch_number: @batch_number.to_i,
          batch_size: size,
          filter: filter_string,
          include_details: @include_details,
          sort: sort
        }.delete_if { |_, v| should_delete(v) }
      end

      private

      def size
        [@batch_size.to_i, MAX_BATCH_SIZE].min
      end

      def sort
        return unless sort_key_valid?
        "#{@sort_key}:#{direction}"
      end

      def direction
        @sort_direction == 'asc' ? :asc : :desc
      end

      def sort_key_valid?
        %w[
          address closing_date created default expiration_date
          listing_date purchase_price review_submission_date updated
        ].include? @sort_key
      end

      def should_delete(value)
        value.nil? ||
          (value.is_a?(Integer) && value.zero?) ||
          ((value.is_a?(String) || value.is_a?(Hash)) && value.empty?)
      end

      def filter_string
        return unless @filter
        @filter.map { |key, value| filter_pair(key, value) }.compact.join(',')
      end

      def filter_pair(key, value)
        return unless FILTER_OPTIONS.include?(key.to_s)
        key.to_s + '=' + param_value_parser(value)
      end

      def param_value_parser(value)
        return value.to_s unless value.is_a?(Array)
        value.map(&:to_s).join('|')
      end
    end
  end
end
