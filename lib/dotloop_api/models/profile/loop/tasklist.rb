module DotloopApi
  module Models
    class Profile
      class Loop
        class TaskList
          include Virtus.model
          attribute :id, Integer
          attribute :name
          attr_accessor :client
          attr_accessor :loop_id
          attr_accessor :profile_id

          def tasks
            DotloopApi::EndPoints::Task.new(
              client: client, profile_id: profile_id, loop_id: loop_id, task_list_id: id
            ).all
          end
        end
      end
    end
  end
end
