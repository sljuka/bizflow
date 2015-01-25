module Bizflow
  module Domain
    
    class Process

      attr_accessor :name, :description, :start_block, :blocks

      def initialize(name)
        @name = name
        @blocks = []
        @roles = []
      end

      def add_block(block)
        blocks << block
      end

    end

  end
end