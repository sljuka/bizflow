require "bizflow/domain_model/domain_repo"
require "bizflow/incubators/domain_incubator"

class Bizflow::DomainBuilder

  attr_accessor :repo, :source_path, :domain_incubator

  def initialize(source_path)
    @repo = Bizflow::DomainRepo.new
    @source_path = source_path
  end


  def build

    @domain_incubator = Bizflow::DomainIncubator.new(repo)
    source_files.each do |path|
      @domain_incubator.instance_eval(File.read(path), path, __LINE__)
    end

  end

  private

  def source_files
    Dir["#{@source_path}/**/*.rb"]
  end

end