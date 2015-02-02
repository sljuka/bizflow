module Bizflow
  module Fakes
    class Block

      attr_accessor :name, :type, :process, :next_blocks, :tasks, :handlers, :block_blueprint

      def initialize(process, block_blueprint, name, type)
        @process = process
        @block_blueprint = block_blueprint
        @name = name
        @type = type
      end

    end
  end
end
