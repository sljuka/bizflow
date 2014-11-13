class Bizflow::AutomatedBlock

  attr_accessor :name, :description, :next_blocks, :handler

  def initialize(name, description = nil)
    @name = name
    @description = description
    @next_blocks = {}
  end

end