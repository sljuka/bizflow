module Bizflow
  module SemanticModel
    
    class Action

      attr_accessor :name, :description, :type, :question

      def initialize(type, name, description = nil)
        @type = type
        @name = name
        @description = nil
      end

      def next_actions
        raise NotImplementedError
      end

      def tasks
        []
      end

      def handler
        nil
      end

    end
  
  end
end
