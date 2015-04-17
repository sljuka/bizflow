require_relative 'simple_wrapper'
require_relative 'head'
require 'bizflow/lib/callbackable'

module Bizflow
  module BusinessModel

    class Process < SimpleWrapper

      include Bizflow::Lib::Callbackable

      def start(runner_id, &block)

        setup_callbacks(&block)
        
        if runned_at != nil
          callback(:already_started, data: self, message: "process has already been started") and return 
        end
        
        ph = Bizflow::BusinessModel::Head.wrap(head)
        ph.jump(start_action_id)
        update(runner_id: runner_id, runned_at: Time.now)        
        
        callback(:success, data: self, message: "process started successfully")

      end

      def finish
        update(finished_at: Time.now)
      end

      private

      def start_action
        Bizflow::DataModel::Action[start_action_id]
      end

    end

  end
end
