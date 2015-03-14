module Bizflow
  module SemanticModel

    class Task

      attr_accessor :name, :description, :roles, :auto_assign

      def initialize(name, options = {})
        @name = name
        @roles = options[:roles]
        @description = options[:description]
        @auto_assign = options[:auto_assign] || false
      end

    end
  
  end
end