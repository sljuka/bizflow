module Bizflow

  class BusinessProcess

    attr_accessor :current_block

    def run
      current_block = start_block
      execute_block
    end

    def execute_block
      if current_block == "process:finish"
        finish
        return nil
      end

      if blocks[current_block.to_sym][:tasks]
        add_tasks(blocks[current_block.to_sym][:tasks])
      end
    end

    def finish

    end

    def start_block
      raise NotImplementedError
    end

    def blocks
      raise NotImplementedError
    end

    def tasks
      raise NotImplementedError
    end

  end

end