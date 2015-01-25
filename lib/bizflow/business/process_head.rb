require_relative 'simple_wrapper'
require_relative 'task_block'

module Bizflow
  module Business
    
    class ProcessHead < SimpleWrapper

      # TODO what about merge
      def jump
        if block.type == "task"
          wb = Bizflow::Business::TaskBlock.wrap(block)
          wb.create_tasks
        else
          puts "auto"
        end
      end

    end

  end
end