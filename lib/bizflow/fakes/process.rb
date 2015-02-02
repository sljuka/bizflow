module Bizflow
  module Fakes
    class Process

      attr_accessor :name, :description, :blocks, :header, :start_block

      def initialize(name, description = nil)
        @name = name
        @description = description
        @blocks = []
      end

    end
  end
end
