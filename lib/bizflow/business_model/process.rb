require_relative 'simple_wrapper'
require_relative 'head'

module Bizflow
  module BusinessModel

    class Process < SimpleWrapper

      def run(runner_id)
        update(runner_id: runner_id, runned_at: Time.now)
        ph = Bizflow::BusinessModel::Head.wrap(head)
        ph.run
      end

      def finish
        t = Time.now
        update(finished_at: t, jumped_at: t)
      end

      def jump
        update(jumped_at: Time.now)
      end

      def start_action
        Bizflow::DataModel::Action[start_action_id]
      end

    end

  end
end
