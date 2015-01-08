require 'delegate'

module Bizflow

  class BusinessProcess < SimpleDelegator

    attr_accessor :repo, :heads

    def initialize(repo, user)
      @heads = []
      @repo = repo
      process = initialize_process(repo, user)
      super(process)
    end

    def run
      head = process.headers.first
      head.jump
    end

    def finish

    end

    def start_block
      raise NotImplementedError
    end

    def block_descriptors
      raise NotImplementedError
    end

    def process_name
      raise NotImplementedError
    end

    private

    def initialize_process(repo, user)
      process = repo.create_process(user_id: user.id, type: process_name)
      create_blocks(process)
      create_process_header(process)
    end

    def create_blocks(process)
      block_descriptors.each do |k, v|
        blck = nil
        if block.type == "auto"
          blck = repo.create_block(process_id: process.id, type: "auto", name: k)
        else
          blck = repo.create_block(process_id: process.id, type: "task", name: k)
        end
        @start_block = blck if blck.name == start_block
      end
    end

    def create_process_header(process)
      head = repo.create_process_header(process_id: process.id, block_id: @start_block.id)
      heads.push()
    end

  end

end
