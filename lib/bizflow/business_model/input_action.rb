require_relative 'simple_wrapper'
require 'bizflow/lib/callbackable'

module Bizflow
  module BusinessModel

    class InputAction < SimpleWrapper

      include Bizflow::Lib::Callbackable

      def resolve
        
      end

      def submit_input(input, &block)

        raise "must have an input" if(input.nil? || input.empty?)
        setup_callbacks(&block)

        if(heads.nil? || heads.empty?)
          callback(:not_active,
            data: self,
            message: "Action is not active, there are no process heads pointing to this action. No inputs can be submited to inactive actions.")
          return
        end        

        na = next_actions.select { |item| item.ending == input }

        if(na.nil? || na.empty?)
          callback(:bad_input,
            data: self,
            message: "Input is not valid. Valid inputs for #{name} are #{next_actions.map(&:ending).join(", ")}")
          return
        end

        next_action = na.first
        bhs = Bizflow::BusinessModel::Head.wraps(heads)
        bhs.each { |h| h.jump(next_action.next_id) }

        callback(:success, data: self, message: "Input submitted to the process successfully.")

      end

    end

  end
end
