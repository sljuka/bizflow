require_relative 'simple_wrapper'

module Bizflow
  module BusinessModel

    class InputAction < SimpleWrapper

      def resolve
        
      end

      def submit_input(input)

        raise "must have an input" unless input

        na = next_actions_dataset.where(ending: input)
        raise "no next action for #{input} name" if na.empty?

        next_action = na.first
        bhs = Bizflow::BusinessModel::Head.wraps(heads)
        bhs.each { |h| h.jump(next_action.next_id) }

        bp = Bizflow::BusinessModel::Process.wrap(process)
        bp.jump

      end

    end

  end
end
