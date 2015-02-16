#sematic model

module Bizflow
  module Domain
    
    class Process

      attr_accessor :name, :description, :start_action, :actions

      def initialize(name)
        @name = name
        @actions = []
        @roles = []
      end

      def add_action(action)
        actions << action
      end

    end

  end
end