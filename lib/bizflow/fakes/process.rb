module Bizflow
  module Fakes
    class Process

      attr_accessor :name, :description, :actions, :heads, :start_action

      def initialize(name, description = nil)
        @name = name
        @description = description
        @heads = []
        @actions = []
      end

    end
  end
end
