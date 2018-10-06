module DotloopApi
  module Models
    class Profile
      # define nested classes first for dependency resolution
      class Loop
        class Activity; end
        class Detail
          class ContractDates; end
          class ContractInfo; end
          class Financials; end
          class GeographicDescription; end
          class ListingInformation; end
          class OfferDates; end
          class Property; end
          class PropertyAddress; end
          class Referral; end
        end
        class Folder
          class Document; end
        end
        class Participant < ::DotloopApi::Models::Contact; end
        class TaskList
          class Task; end
        end
      end
      class LoopTemplate; end

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
        loop_endpoint.find(id: id)
      end

      def loop_templates
        DotloopApi::EndPoints::LoopTemplate.new(client: client, profile_id: id).all
      end

      private

      def loop_endpoint
        DotloopApi::EndPoints::Loop.new(client: client, profile_id: id)
      end
    end
  end
end
