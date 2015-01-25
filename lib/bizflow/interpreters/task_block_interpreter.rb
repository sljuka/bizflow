
require "bizflow/domain/task_block"
require "bizflow/domain/task"

class Bizflow::TaskBlockInterpreter

  attr_accessor :block

  def initialize(name)
    @block = Bizflow::Domain::TaskBlock.new(name)
  end

  def next_block(name)
    block.next_block = name
  end

  def description(description)
    block.description = description
  end

  def task(name, options)
    block.add_task(Bizflow::Domain::Task.new(name, options))
  end

end