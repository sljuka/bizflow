
require "bizflow/domain_model/task_block"
require "bizflow/domain_model/task"

class Bizflow::TaskBlockInterpreter

  attr_accessor :block

  def initialize(name)
    @block = Bizflow::TaskBlock.new(name)
  end

  def next_block(name)
    @block.next_block = name
  end

  def description(description)
    @block.description = description
  end 

  def task(task, roles, description = nil)
    @block.add_task(Bizflow::Task.new(task, roles, description))
  end

end