require 'erb'
require 'fileutils'
require 'bizflow/source_presenters/process_template_presenter'

class Bizflow::SourceGenerator

  TemplatesPath = "#{File.dirname(__FILE__)}/templates/js"

  attr_reader :domain_repo

  def initialize(builder)
    @builder = builder
    @domain_repo = @builder.build
  end

  def generate(source_dest)
    generate_processes(source_dest)
    #generate_handlers(source_dest)
  end

  def generate_processes(source_dest)

    domain_repo.processes.each do |_, process|
      presenter = Bizflow::ProcessTemplatePresenter.new(process)
      process_source = ERB.new(File.read("#{TemplatesPath}/process.tt"), nil, '-').result(presenter.get_binding)
      out_file = File.new("#{source_dest}/#{presenter.name}.json", "w")
      out_file.puts(process_source)
      out_file.close
    end

  end

  def generate_handlers(source_dest)
    
    domain_repo.processes.each do |_, process|
      presenter = Bizflow::ProcessTemplatePresenter.new(process)
      handler_source = ERB.new(File.read("#{TemplatesPath}/handler.tt")).result(presenter.get_binding)
      Dir.mkdir "#{source_dest}/handlers"
      process.handlers.each do |handler|
        out_file = File.new("#{source_dest}/handlers/#{handler.name}.rb", "w")
        out_file.puts(handler_source)
        out_file.close
      end
    end

  end

end
