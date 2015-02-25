require_relative 'simple_wrapper'
require_relative 'head'

module Bizflow
  module BusinessModel

    class Process < SimpleWrapper

      def run(runner_id)
        ph = Bizflow::BusinessModel::Head.wrap(heads.first)
        action_name = start.name
        update(runner_id: runner_id, runned_at: Time.now)
        while action_name do
          ph.action = actions.select { |a| a.name == action_name }.first
          action_name = ph.jump
        end
      end

      def finish
        puts "process finished"
      end

    end

  end
end
