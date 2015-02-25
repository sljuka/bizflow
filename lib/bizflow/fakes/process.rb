module Bizflow
  module Fakes
    class Process

      attr_accessor :name, :description, :actions, :heads, :start

      def initialize(name, description = nil)
        @name = name
        @description = description
        @heads = []
        @actions = []
      end

      def update(*args)

      end

    end
  end
end
