require_relative 'simple_wrapper'
require_relative 'head'

module Bizflow
  module Business

    class Process < SimpleWrapper

      def run
        ph = Bizflow::Business::Head.wrap(heads.first)
        action_name = start_action.name
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
