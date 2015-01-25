
require "bizflow/domain/automated_block"
require "bizflow/domain/handler"

class Bizflow::AutomatedBlockInterpreter

  attr_accessor :block

  def initialize(name)
    @block = Bizflow::Domain::AutomatedBlock.new(name)
  end

  def description(description)
    block.description = description
  end

  def handler(name, options = {})
    raise "handler for block already defined" if block.handler
    block.handler = Bizflow::Domain::Handler.new(name, options)
  end

  def next_blocks(blocks_hash)
    raise "next blocks already defined" if !block.next_blocks.empty?
    block.next_blocks = blocks_hash
  end

end