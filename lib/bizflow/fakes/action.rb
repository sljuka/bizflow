module Bizflow
  module Fakes
    class Action

      attr_accessor :name, :type, :process, :next_actions, :tasks, :handlers, :action_blueprint

      def initialize(process, action_blueprint, name, type)
        @process = process
        @action_blueprint = action_blueprint
        @name = name
        @type = type
      end

    end
  end
end
