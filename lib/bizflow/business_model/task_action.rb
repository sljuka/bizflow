require_relative 'simple_wrapper'

module Bizflow
  module BusinessModel

    class TaskAction < SimpleWrapper

      def resolve
        action_blueprint.task_blueprints.each do |tbp|
          add_task(name: tbp.name, task_blueprint: tbp)
        end
      end

      def finish
        bhs = Bizflow::BusinessModel::Head.wraps(heads)
        bp = Bizflow::BusinessModel::Process.wrap(process)
        next_action_id = next_action ? next_action.id : nil
        bhs.each { |h| h.jump(next_action_id) }
      end

      def next_action
        nexts.first
      end

      def active
        tasks_dataset.where(finished_at: nil).all
      end

      def task_finished
        finish if active.empty?
      end

    end

  end
end
