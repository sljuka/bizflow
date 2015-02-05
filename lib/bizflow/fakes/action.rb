require_relative 'task'

module Bizflow
  module Fakes
    class Action

      attr_accessor :name, :type, :process, :next_actions, :tasks, :handlers, :action_blueprint

      def initialize(process, action_blueprint, name, type)
        @process = process
        @action_blueprint = action_blueprint
        @name = name
        @type = type
        @tasks = []
      end

      def add_task(hash)
        tasks << Bizflow::Fakes::Task.new(self, hash[:name], hash[:description])
      end

    end
  end
end
