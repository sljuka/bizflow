module Bizflow
  module Domain
    
    class Block

      attr_accessor :name, :description, :type

      def initialize(type, name, description = nil)
        @type = type
        @name = name
        @description = nil
      end

    end
  
  end
end
