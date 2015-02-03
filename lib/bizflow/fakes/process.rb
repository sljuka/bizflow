module Bizflow
  module Fakes
    class Process

      attr_accessor :name, :description, :actions, :header, :start_action

      def initialize(name, description = nil)
        @name = name
        @description = description
        @actions = []
      end

    end
  end
end
