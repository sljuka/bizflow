module Bizflow
  module Domain
    
    class Action

      attr_accessor :name, :description, :type

      def initialize(type, name, description = nil)
        @type = type
        @name = name
        @description = nil
      end

    end
  
  end
end
