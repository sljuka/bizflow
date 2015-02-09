module Bizflow
  module Fakes
    class Handler

      attr_accessor :constant, :path, :block, :finished

      def initialize(action, name, namespace)
        @action = action
        @name = name
        @namespace = namespace
      end

      def handle

      end

    end
  end
end
