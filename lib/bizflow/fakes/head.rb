module Bizflow
  module Fakes
    class Head

      attr_accessor :process, :action

      def initialize(process, action = nil)
        @process = process
        @actions = [action]
      end

    end
  end
end
