require_relative 'simple_wrapper'
require_relative 'handler'
require_relative 'task_action'
require_relative 'automated_action'

module Bizflow
  module BusinessModel

    class Head < SimpleWrapper

      ActionHash = {
        task: Bizflow::BusinessModel::TaskAction,
        auto: Bizflow::BusinessModel::AutomatedAction
      }

      # TODO what about merge
      def jump
        resolve_action(action)
      end

      private

      def resolve_action(action)
        ba = ActionHash[action.type.to_sym].new(action)
        ba.resolve
      end

    end

  end
end