require_relative 'simple_wrapper'
require 'bizflow/lib/callbackable'

module Bizflow
  module BusinessModel

    class Task < SimpleWrapper

      include Bizflow::Lib::Callbackable

      def assign(user_id, &block)
        setup_callbacks(&block)

        if(finished_at != nil)
          callback(:already_finished, data: self, message: "Task has already been finished.")
          return
        end

        update(assignee_id: user_id)

        callback(:success, data: self, message: "Task assigned successfully.")
      end

      def finish(user_id, &block)
        setup_callbacks(&block)

        if(finished_at != nil)
          callback(:already_finished, data: self, message: "Task has already been finished.")
          return
        end

        update(finished_at: Time.now)
        Bizflow::BusinessModel::TaskAction.wrap(action).task_finished

        callback(:success, data: self, message: "Task has been finished successfully.")
      end

    end
    
  end
end