module Bizflow
  module Fakes
    class Handler

      attr_accessor :name, :namespace, :action, :finished

      def initialize(action, name, namespace)
        @action = action
        @name = name
        @namespace = namespace
      end

    end
  end
end
