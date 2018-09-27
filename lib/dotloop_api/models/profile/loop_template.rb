module DotloopApi
  module Models
    class Profile
      class LoopTemplate
        include Virtus.model
        attribute :id, Integer
        attribute :profile_id, Integer
        attribute :name
        attribute :transaction_type
        attribute :shared, Boolean
        attribute :global, Boolean
        attr_accessor :client
      end
    end
  end
end
