require 'erb'
require 'bizflow/source_presenters/process_template_presenter'

class Bizflow::SourceGenerator

  TemplatesPath = "#{File.dirname(__FILE__)}/templates"

  def initialize(builder)
    @builder = builder
  end

  def generate(source_dest)
    domain_repo = @builder.build

    domain_repo.processes.each do |_, process|
      presenter = Bizflow::ProcessTemplatePresenter.new(process)
      process_source = ERB.new(File.read("#{TemplatesPath}/process.tt")).result(presenter.get_binding)
      out_file = File.new("#{source_dest}/#{presenter.name}.rb", "w")
      out_file.puts(process_source)
      out_file.close
    end

  end

end
