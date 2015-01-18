require 'bizflow/external/simple_wrapper'

module Bizflow

  class BusinessProcess < SimpleWrapper

    def run
      puts "process ran"
    end

    def finish
      puts "process finished"
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

    def self.process_dir
      @dir
    end

    def self.root
      dir = self.class.process_dir
      #puts "1 #{dir}"
      10.times do |i|
        files = Dir["#{dir}/*.rb"].map { |path| File.basename(path) }
        #puts "2 #{files}"
        break if(files.include?(ConfigFileName))
        dir = File.expand_path("../", dir)
        #puts "1 #{dir}"
        raise "Unable to locate root directory" if i >= 9
      end

      dir
    end

  end

end
