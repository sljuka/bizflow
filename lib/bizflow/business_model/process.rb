require_relative 'simple_wrapper'
require_relative 'head'

module Bizflow
  module BusinessModel

    class Process < SimpleWrapper

      def run(runner_id)
        ph = Bizflow::BusinessModel::Head.wrap(heads.first)
        action = Bizflow::DataModel::Action[start_action_id]
        update(runner_id: runner_id, runned_at: Time.now)
        while action do
          ph.update(action: action)
          action = ph.jump
        end
      end

      def finish
        puts "process finished"
      end

    end

  end
end
