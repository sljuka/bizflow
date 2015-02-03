module Bizflow
  module Fakes
    class Task

      attr_accessor :name, :description, :action

      def initialize(action, name, description = nil)
        @action = action
        @name = name
        @description = description
      end

    end
  end  
end
