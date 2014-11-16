
require "bizflow/domain_model/automated_block"
require "bizflow/domain_model/handler"

class Bizflow::AutomatedBlockInterpreter

  attr_accessor :block

  def initialize(name)
    @block = Bizflow::AutomatedBlock.new(name)
  end

  def description(description)
    @block.description = description
  end

  def handler(handler_full_name, description = nil)
    namespace, name = handler_full_name.split(":")
    @block.handler = Bizflow::Handler.new(namespace, name, description)
  end

  def next_blocks(next_blocks_hash)
    @block.next_blocks = next_blocks_hash
  end

end