require "bizflow/domain_model/block"

class Bizflow::AutomatedBlock < Bizflow::Block

  attr_accessor :next_blocks, :handler

  def initialize(name)
    super("auto", name)
    @next_blocks = {}
    @handler = nil
  end

end