module Bizflow
  module Fakes
    class Task

      attr_accessor :name, :description, :block

      def initialize(block, name, description = nil)
        @block = block
        @name = name
        @description = description
      end

    end
  end  
end
