module DotloopApi
  module Models
    class Profile
      class Loop
        class Activity
          include Virtus.model
          attribute :date, Time
          attribute :message
        end
      end
    end
  end
end
