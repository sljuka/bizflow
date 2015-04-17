require 'bizflow/lib/callback_handler'

module Bizflow
  module Lib
    module Callbackable

      private

      def setup_callbacks
        raise "business method needs a block" unless block_given?
        callback_handler.clear()
        yield(callback_handler)
      end

      def callback(name, *args)
        @callback_handler.callback(name, args[0])
      end

      def callback_handler
        @callback_handler ||= Bizflow::Lib::CallbackHandler.new
      end

    end
  end
end