require_relative 'simple_wrapper'

module Bizflow
  module BusinessModel

    class Task < SimpleWrapper

      def assign(user_id)
        update(assignee_id: user_id)
      end

      def auto_assign(role)

      end

      def finish(user_id)
        update(finished_at: Time.now)
        Bizflow::BusinessModel::TaskAction.wrap(action).task_finished
      end

    end
    
  end
end