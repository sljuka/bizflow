require_relative "action"

module Bizflow
  module SemanticModel
    
    class InputAction < Action

      attr_accessor :next_actions, :handler

      def initialize(name)
        super("input", name)
        @next_actions = {}
        @handler = nil
      end
  
    end
  
  end
end