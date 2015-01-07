require 'erb'
require 'fileutils'
require 'bizflow/source_presenters/process_template_presenter'

module Bizflow
  class SourceGenerator

    JsTemplatesPath = "#{File.dirname(__FILE__)}/templates/js"
    RbTemplatesPath = "#{File.dirname(__FILE__)}/templates/rb"

    attr_reader :domain_repo

    def initialize(builder)
      @builder = builder
      @domain_repo = @builder.build
    end

    def generate(config)
      generate_processes(config[:dest_process_path])
      generate_processes_descriptor(config[:dest_descriptor_path])
      #generate_handlers(source_dest)
    end

    def generate_processes(source_dest)

      domain_repo.processes.each do |_, process|
        presenter = Bizflow::ProcessTemplatePresenter.new(process)
        process_source = ERB.new(File.read("#{RbTemplatesPath}/process.tt"), nil, '-').result(presenter.get_binding)
        out_file = File.new("#{source_dest}/#{presenter.name}.rb", "w")
        out_file.puts(process_source)
        out_file.close
      end

    end

    def generate_handlers(source_dest)
      
      domain_repo.processes.each do |_, process|
        presenter = Bizflow::ProcessTemplatePresenter.new(process)
        handler_source = ERB.new(File.read("#{RbTemplatesPath}/handler.tt")).result(presenter.get_binding)
        Dir.mkdir "#{source_dest}/handlers"
        process.handlers.each do |handler|
          out_file = File.new("#{source_dest}/handlers/#{handler.name}.rb", "w")
          out_file.puts(handler_source)
          out_file.close
        end
      end

    end

    def generate_processes_descriptor(source_dest)

      descriptor = ERB.new(File.read("#{JsTemplatesPath}/descriptor.tt"), nil, '-').result(domain_repo.get_binding)
      out_file = File.new("#{source_dest}/process-descriptor.json", "w")
      out_file.puts(descriptor)
      out_file.close
    
    end

  end

end
