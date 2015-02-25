module Bizflow
  module SemanticModel

    class Handler

      attr_accessor :namespace, :name, :description

      def initialize(name, options = {})
        @name = name
        @namespace = options[:namespace]
        @description = options[:description]
      end

      def full_name
        "#{namespace}:#{name}"
      end

    end
  
  end
end