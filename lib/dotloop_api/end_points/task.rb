module DotloopApi
  module EndPoints
    class Task < DotloopApi::EndPoints::Base
      attr_accessor :profile_id
      attr_accessor :loop_id
      attr_accessor :task_list_id
      undef_method :save
      undef_method :create
      undef_method :delete

      def initialize(client:, profile_id: nil, loop_id: nil, task_list_id: nil)
        @profile_id = profile_id
        @loop_id = loop_id
        @task_list_id = task_list_id
        super(client: client, path: path, type: DotloopApi::Models::Profile::Loop::TaskList::Task)
      end

      def path
        "/profile/#{@profile_id}/loop/#{@loop_id}/tasklist/#{@task_list_id}/task"
      end
    end
  end
end
