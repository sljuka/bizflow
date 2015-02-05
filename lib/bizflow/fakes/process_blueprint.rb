module Bizflow
  module Fakes
    class Process

      attr_accessor :name, :description

      def initialize(name, description = nil)
        @name = name
        @description = description
      end

    end
  end
end
