require_relative 'simple_wrapper'
require_relative 'handler'
require_relative 'task_action'
require_relative 'input_action'
require_relative 'process'

module Bizflow
  module BusinessModel

    class Head < SimpleWrapper

      ActionHash = {
        task: Bizflow::BusinessModel::TaskAction,
        input: Bizflow::BusinessModel::InputAction
      }

      def jump(next_id = nil)

        if next_id.nil?
          Bizflow::BusinessModel::Process.wrap(process).finish
          return
        end

        update(action_id: next_id)
        raise "Head does not point to an action" unless action
        bus_action = ActionHash[action.type.to_sym].new(action)
        bus_action.resolve
        
      end

    end

  end
end
