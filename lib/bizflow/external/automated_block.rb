require 'bizflow/external/simple_wrapper'

module Bizflow

  class AutomatedBlock < SimpleWrapper

    def initialize(process, user)
      self.task_type = "auto"
      self.bf_process_id = process.id
      self.user_id = user.id
    end


  end

end
