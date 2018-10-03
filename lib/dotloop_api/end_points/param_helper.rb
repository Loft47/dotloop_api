module DotloopApi
  module EndPoints
    class ParamHelper
      include Virtus.model
      attribute :batch_number, Integer, default: 1
      attribute :batch_size, Integer, default: 100
      attribute :filter
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
          filter: filter_hash,
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

      def filter_hash
        (@filter.to_s.split('&').map { |var| var.split('=') }).to_h.slice(*FILTER_OPTIONS)
      end
    end
  end
end
