require 'bizflow/domain_builder'
require 'bizflow/source_generator'

module Bizflow
  class BuildCommand

    def self.run(config, args)

      dest_process_path = "#{Dir.pwd}/#{config[:process_dest_path]}" || "#{Dir.pwd}/#{args[1]}"
      dest_handler_path = "#{Dir.pwd}/#{config[:process_handler_dest_path]}" || "#{Dir.pwd}/#{args[1]}"
      dest_descriptor_path = "#{Dir.pwd}/#{config[:descriptor_dest_path]}" || "#{Dir.pwd}/."

      generator_config = {
        dest_process_path: dest_process_path,
        dest_handler_path: dest_handler_path,
        dest_descriptor_path: dest_descriptor_path
      }

      source_path = "#{Dir.pwd}/#{config[:source_path]}" || "#{Dir.pwd}/#{args[0]}"
      dest_path = 
      db = Bizflow::DomainBuilder.new(source_path)
      sg = Bizflow::SourceGenerator.new(db)

      sg.generate(generator_config)
      puts "processes built in #{dest_path}"
    end

  end
end