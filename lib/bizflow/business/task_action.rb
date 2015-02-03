require_relative 'simple_wrapper'

module Bizflow
  module Business

    class TaskAction < SimpleWrapper

      def create_tasks
        action_blueprint.task_blueprints.each do |tbp|
          add_task(name: tbp.name, task_blueprint_id: tbp.id)
        end
      end

    end

  end
end
