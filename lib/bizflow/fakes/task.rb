module Bizflow
  module Fakes
    class Task

      attr_accessor :name, :description, :action, :assignee_id, :auto_assign

      def initialize(action, name, auto_assign = false, description = nil)
        @action = action
        @name = name
        @description = description
        @auto_assign = auto_assign
      end

    end
  end  
end
