require_relative 'simple_wrapper'
require_relative 'task_action'

module Bizflow
  module Business
    
    class ProcessHead < SimpleWrapper

      # TODO what about merge
      def jump
        if action.type == "task"
          wb = Bizflow::Business::TaskAction.wrap(action)
          wb.create_tasks
        else
          puts "auto"
        end
      end

    end

  end
end