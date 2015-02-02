module Bizflow
  module Fakes
    class Handler

      attr_accessor :constant, :path, :block

      def initialize(block, constant, path)
        @block = block
        @constant = constant
        @path = path
      end

    end
  end
end
