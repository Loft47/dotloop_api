module DotloopApi
  module Models
    class Profile
      class Loop
        STATUS_TYPES = {
          PURCHASE_OFFER: %w[ARCHIVED PRE_OFFER SOLD UNDER_CONTRACT],
          LISTING_FOR_SALE: %w[ACTIVE_LISTING ARCHIVED PRE_LISTING PRIVATE_LISTING SOLD UNDER_CONTRACT],
          LISTING_FOR_LEASE: %w[ACTIVE_LISTING ARCHIVED LEASED PRE_LISTING PRIVATE_LISTING UNDER_CONTRACT],
          LEASE_OFFER: %w[ARCHIVED LEASED PRE_OFFER UNDER_CONTRACT],
          REAL_ESTATE_OTHER: %w[ARCHIVED DONE IN_PROGRESS NEW],
          OTHER: %w[ARCHIVED DONE IN_PROGRESS NEW]
        }.freeze
        TRANSACTION_TYPES = STATUS_TYPES.keys
        include Virtus.model
        attribute :completed_task_count, Integer, default: 0
        attribute :created
        attribute :id, Integer
        attribute :loop_url
        attribute :name
        attribute :owner_profile_id, Integer
        attribute :profile_id, Integer
        attribute :status
        attribute :total_task_count, Integer, default: 0
        attribute :transaction_type
        attribute :updated
        attribute :details, DotloopApi::Models::Profile::Loop::Detail
        attr_accessor :client

        def activities
          DotloopApi::EndPoints::Activity.new(client: client, profile_id: profile_id, loop_id: id).all
        end

        def detail
          @details = DotloopApi::EndPoints::Detail.new(
            client: client, profile_id: profile_id, loop_id: id
          ).find
        end

        def folders(options = {})
          DotloopApi::EndPoints::Folder.new(
            client: client, profile_id: profile_id, loop_id: id
          ).all(options)
        end

        def task_lists
          DotloopApi::EndPoints::TaskList.new(client: client, profile_id: profile_id, loop_id: id).all
        end
      end
    end
  end
end
