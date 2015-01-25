require_relative "block"

module Bizflow
  module Domain
    
    class AutomatedBlock < Block

      attr_accessor :next_blocks, :handler

      def initialize(name)
        super("auto", name)
        @next_blocks = {}
        @handler = nil
      end
  
    end
  
  end
end