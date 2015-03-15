require_relative "action"

module Bizflow
  module SemanticModel

    class TaskAction < Action

      attr_accessor :tasks, :next_action

      def initialize(name)
        super("task", name)
        @tasks = [] 
      end

      def add_task(task)
        tasks << task
      end

      def next_actions
        { only_one: next_action }
      end

    end
  
  end
end