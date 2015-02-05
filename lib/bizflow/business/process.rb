require_relative 'simple_wrapper'
require_relative 'head'

module Bizflow
  module Business

    class Process < SimpleWrapper

      def run
        ph = Bizflow::Business::Head.wrap(heads.first)
        ph.jump
      end

      def finish
        puts "process finished"
      end

    end

  end
end
