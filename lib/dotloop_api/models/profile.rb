module DotloopApi
  module Models
    class Profile
      # define nested classes first for dependency resolution
      class Loop
        class Activity; end # rubocop:disable Lint/EmptyClass

        class Detail
          class ContractDates; end # rubocop:disable Lint/EmptyClass
          class ContractInfo; end # rubocop:disable Lint/EmptyClass
          class Financials; end # rubocop:disable Lint/EmptyClass
          class GeographicDescription; end # rubocop:disable Lint/EmptyClass
          class ListingInformation; end # rubocop:disable Lint/EmptyClass
          class OfferDates; end # rubocop:disable Lint/EmptyClass
          class Property; end # rubocop:disable Lint/EmptyClass
          class PropertyAddress; end # rubocop:disable Lint/EmptyClass
          class Referral; end # rubocop:disable Lint/EmptyClass
        end

        class Folder
          class Document; end # rubocop:disable Lint/EmptyClass
        end

        class Participant < ::DotloopApi::Models::Contact; end

        class TaskList
          class Task; end # rubocop:disable Lint/EmptyClass
        end
      end

      class LoopTemplate; end # rubocop:disable Lint/EmptyClass

      PROFILE_TYPES = %w[ASSOCIATION COMPANY INDIVIDUAL NATIONAL_PARTNER OFFICE TEAM].freeze
      include Virtus.model
      attribute :address
      attribute :city
      attribute :company
      attribute :country
      attribute :default, Boolean, default: false
      attribute :fax
      attribute :id, Integer
      attribute :name
      attribute :phone
      attribute :state
      attribute :type
      attribute :zipcode
      attr_accessor :client

      def loops(options = {})
        loop_endpoint.all(options)
      end

      def loop(id)
        loop_endpoint.find(id:)
      end

      def loop_templates
        DotloopApi::EndPoints::LoopTemplate.new(client:, profile_id: id).all
      end

      private

      def loop_endpoint
        DotloopApi::EndPoints::Loop.new(client:, profile_id: id)
      end
    end
  end
end
