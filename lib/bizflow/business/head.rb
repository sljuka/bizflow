require_relative 'simple_wrapper'
require_relative 'task_action'
require_relative 'automated_action'
require_relative 'handler'

module Bizflow
  module Business
    
    class Head < SimpleWrapper

      # TODO what about merge
      def jump
        if action.type == "task"
          ta = Bizflow::Business::TaskAction.wrap(action)
          ta.create_tasks
          nil
        else
          aa = Bizflow::Business::TaskAction.wrap(action)
          handler = aa.handlers.first
          bus_handler = Handler.new(handler)
          res = bus_handler.handle
          bus_handler.finished = true
          res
        end
      end

    end

  end
end