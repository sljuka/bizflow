require_relative 'simple_wrapper'

module Bizflow
  module BusinessModel

    class InputAction < SimpleWrapper

      def resolve
        
        action_blueprint.task_blueprints.each do |tbp|
          add_task(name: tbp.name, task_blueprint: tbp)
        end

        nil
        
      end

    end

  end
end
