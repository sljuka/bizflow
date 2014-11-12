
require "bizflow/task_block"

class Bizflow::TaskBlockIncubator

  attr_accessor :block

  def initialize(name)
    @block = Bizflow::TaskBlock.new(name)
  end

  def next_block(name)

  end

  def description(description)

  end 

  def tasks(tasks)

  end

  def roles(roles)

  end

end