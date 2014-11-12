
require "bizflow/automated_block"

class Bizflow::AutomatedBlockIncubator

  attr_accessor :block

  def initialize(name)
    @block = Bizflow::AutomatedBlock.new(name)
  end

  def description(description)

  end

  def handler(handler)

  end

  def next_block(next_block_name)

  end

end