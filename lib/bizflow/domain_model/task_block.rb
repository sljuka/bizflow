require "bizflow/domain_model/block"

module Bizflow

  class TaskBlock < Block

    attr_accessor :tasks, :next_block

    def initialize(name)
      super("task", name)
      @tasks = []
      @next_block 
    end

    def add_task(task)
      tasks << task
    end

  end

end