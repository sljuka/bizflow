require_relative 'simple_wrapper'
require_relative 'process_head'

module Bizflow
  module Business

    class Process < SimpleWrapper

      def run
        ph = Bizflow::Business::ProcessHead.wrap(process_heads.first)
        ph.jump
      end

      def finish
        puts "process finished"
      end

    end

  end
end
