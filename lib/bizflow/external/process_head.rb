require 'delegate'

module Bizflow

  class ProcessHead < SimpleDelegator

    attr_accessor :block, :process

    def initialize(process, block)
      @process = process
      @block = block
    end

    # TODO what about merge
    def execute
      if block.type == :end
        process.finish
      elsif block.type == :task
        create_tasks(block)
      else
        block = block.handler.execute
        persist_header
        execute
      end
    end

    def persist_header
      raise NotImplementedError
    end

  end

end