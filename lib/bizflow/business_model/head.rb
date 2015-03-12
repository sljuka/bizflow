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
        update(action_id: process.start_action_id)
        jump
      end

      # TODO what about merge
      def jump
        raise "Head does not point to an action" unless action
        next_action = resolve_action(action)
        while next_action
          next_action = resolve_action(next_action)
        end
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