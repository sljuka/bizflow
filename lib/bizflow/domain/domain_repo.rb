module Bizflow
  module Domain
    
    class DomainRepo

      attr_accessor :processes

      def initialize
        @processes = []
      end

      def add_process(process)
        processes << process
      end

    end
  
  end
end
