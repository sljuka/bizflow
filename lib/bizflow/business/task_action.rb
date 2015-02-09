require_relative 'simple_wrapper'

module Bizflow
  module Business

    class TaskAction < SimpleWrapper

      def create_tasks
        action_blueprint.task_blueprints.each do |tbp|
          hash = { name: tbp.name, task_blueprint: tbp }
          hash.merge(assignee_id: 1) if tbp.auto_assign
          add_task(name: tbp.name, task_blueprint: tbp)
        end
      end

    end

  end
end
