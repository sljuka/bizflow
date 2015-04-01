require_relative "action"

module Bizflow
  module SemanticModel
    
    class InputAction < Action

      attr_accessor :next_actions, :control_input

      def initialize(name)
        super("input", name)
        @next_actions = {}
        @control_input = nil
      end
  
    end
  
  end
end