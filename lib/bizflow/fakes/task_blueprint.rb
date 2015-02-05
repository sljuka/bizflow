require_relative 'task_blueprint'

module Bizflow
  module Fakes
    class TaskBlueprint

      attr_accessor :name, :roles, :description, :auto_assign, :action_blueprint

      def initialize(action_blueprint, name, roles, description = nil, auto_assign = nil)
        @action_blueprint = action_blueprint
        @name = name
        @roles = roles
        @description = description
        @auto_assign = auto_assign || false
      end

    end
  end
end
