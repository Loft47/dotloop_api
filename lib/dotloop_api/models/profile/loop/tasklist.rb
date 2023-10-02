module DotloopApi
  module Models
    class Profile
      class Loop
        class TaskList
          include Virtus.model
          attribute :id, Integer
          attribute :name
          attr_accessor :client, :loop_id, :profile_id

          def tasks
            DotloopApi::EndPoints::Task.new(
              client:, profile_id:, loop_id:, task_list_id: id
            ).all
          end
        end
      end
    end
  end
end
