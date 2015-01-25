require_relative 'simple_wrapper'

module Bizflow
  module Business

    class TaskBlock < SimpleWrapper

      def create_tasks
        block_blueprint.task_blueprints.each do |tbp|
          add_task(name: tpb.name, task_blueprint_id: tbp.id)
        end
      end

    end

  end
end
