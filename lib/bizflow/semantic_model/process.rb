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

      def task_actions
        actions.select { |acc| acc.type == "task" }
      end

      def input_actions
        actions.select { |acc| acc.type == "input"}
      end

    end

  end
end