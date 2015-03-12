require_relative 'simple_wrapper'

module Bizflow
  module BusinessModel

    class TaskAction < SimpleWrapper

      def resolve
        action_blueprint.task_blueprints.each do |tbp|
          add_task(name: tbp.name, task_blueprint: tbp)
        end

        nil
      end

      def task_finished
        if active.empty?
          heads_dataset.update(action_id: next_action.id)
          head.jump
        end
      end

      def active
        tasks_dataset.where(finished_at: nil).all
      end

      def next_action
        actions.first
      end

    end

  end
end
