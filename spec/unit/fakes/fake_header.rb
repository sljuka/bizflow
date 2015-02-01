module Fakes
  class FakeHeader

    attr_accessor :block, :process, :id

    def initialize(block, process)
      @block = block
      @process = process
    end

  end
end
