module Bizflow
  module Lib
    class CallbackHandler

      attr_accessor :callbacks

      def initialize
        @callbacks = {}
      end

      def method_missing(name, *args, &block)
        raise "Callback #{name} registered more times" if @callbacks[name.to_sym]
        @callbacks[name.to_sym] = block
      end

      def callback(name, *args)
        raise "Callback '#{name}' not registered" unless @callbacks[name.to_sym]
        @callbacks[name.to_sym].call(args)
      end

    end
  end
end