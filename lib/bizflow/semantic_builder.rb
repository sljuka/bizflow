require "bizflow/semantic_model/domain_repo"
require "bizflow/interpreters/domain_interpreter"

class Bizflow::SemanticBuilder

  attr_accessor :repo, :source_path, :domain_interpreter

  def initialize(source_path)
    @repo = Bizflow::SemanticModel::DomainRepo.new
    @source_path = source_path
  end


  def build

    @domain_interpreter = Bizflow::DomainInterpreter.new(repo)
    source_files.each do |path|
      @domain_interpreter.instance_eval(File.read(path), path, __LINE__)
    end
    repo

  end

  private

  def source_files
    Dir["#{@source_path}/**/*.rb"]
  end

end