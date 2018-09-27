module DotloopApi
  module Models
    class Profile
      class Loop
        class TaskList
          class Task
            include Virtus.model
            attribute :due, Time
            attribute :id, Integer
            attribute :name
          end
        end
      end
    end
  end
end
