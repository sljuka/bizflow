require "bizflow/domain_model/block"

class Bizflow::AutomatedBlock < Bizflow::Block

  attr_accessor :name, :description, :next_blocks, :handler

  def initialize(name)
    super
    @next_blocks = {}
    @handler = nil
  end

end