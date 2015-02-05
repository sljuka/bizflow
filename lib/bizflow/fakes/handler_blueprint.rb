require_relative 'task_blueprint'

module Bizflow
  module Fakes
    class HandlerBlueprint

      attr_accessor :name, :namespace, :description, :action_blueprint

      def initialize(action_blueprint, name, namespace, description = nil)
        @action_blueprint = action_blueprint
        @name = name
        @namespace = namespace
        @description = description
      end

    end
  end
end
