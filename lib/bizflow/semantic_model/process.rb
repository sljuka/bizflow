module Bizflow
  module SemanticModel
    
    class Process

      attr_accessor :name, :description, :start, :actions

      def initialize(name)
        @name = name
        @actions = []
        @roles = []
      end

      def add_action(action)
        actions << action
      end

    end

  end
end