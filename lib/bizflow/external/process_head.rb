require 'bizflow/external/simple_wrapper'
require 'bizflow/external/task_block'
require 'bizflow/external/automated_block'

module Bizflow

  class ProcessHead < SimpleWrapper

    # TODO what about merge
    def jump(block, block_descriptors, task_descriptors)
      if block.type == "task"
        wtb = TaskBlock.new(block)
        block.create_tasks(block_descriptors, task_descriptors)
      else
        block = block.handler.execute
        persist_header
        execute
      end
    end

  end

end