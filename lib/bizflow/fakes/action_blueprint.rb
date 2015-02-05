require_relative 'task_blueprint'

module Bizflow
  module Fakes
    class ActionBlueprint

      attr_accessor :name, :type, :description, :process_blueprint, :task_blueprints, :handler_blueprints

      def initialize(process_blueprint, name, type, description = nil, task_blueprints = [], handler_blueprints)
        @process_blueprint = process_blueprint
        @name = name
        @type = type
        @description = description
        @task_blueprints = task_blueprints
        @handler_blueprints = handler_blueprints
      end

      def add_task(hash)
        task_blueprints << Bizflow::Fakes::TaskBlueprint.new(self, hash[:name], hash[:description])
      end

    end
  end
end
