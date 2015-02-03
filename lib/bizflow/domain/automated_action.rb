require_relative "action"

module Bizflow
  module Domain
    
    class AutomatedAction < Action

      attr_accessor :next_actions, :handler

      def initialize(name)
        super("auto", name)
        @next_actions = {}
        @handler = nil
      end
  
    end
  
  end
end