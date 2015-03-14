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
        finish if active.empty?
      end

      def finish
        bhs = Bizflow::BusinessModel::Head.wraps(heads)
        bp = Bizflow::BusinessModel::Process.wrap(process)
        if next_action
          bhs.each { |h| h.jump(next_action.id) }
          bp.jump
        else
          bhs.each { |h| h.finish }
          bp.finish
        end
      end

      def active
        tasks_dataset.where(finished_at: nil).all
      end

      def next_action
        nexts.first
      end

    end

  end
end
