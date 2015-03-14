require_relative 'simple_wrapper'
require_relative 'handler'
require_relative 'task_action'
require_relative 'input_action'

module Bizflow
  module BusinessModel

    class Head < SimpleWrapper

      ActionHash = {
        task: Bizflow::BusinessModel::TaskAction,
        input: Bizflow::BusinessModel::InputAction
      }

      def run
        jump(process.start_action_id)
      end

      # TODO what about merge
      def jump(next_id = nil)

        update(action_id: next_id) if next_id
        raise "Head does not point to an action" unless action
        next_action = resolve_action(action)
        while next_action
          next_action = resolve_action(next_action)
        end
        
      end

      def finish
        update(action_id: nil)
      end

      private

      def resolve_action(action)
        update(action: action)
        ba = ActionHash[action.type.to_sym].new(action)
        ba.resolve
      end

    end

  end
end