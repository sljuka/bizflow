require "bizflow/incubators/process_incubator"


class Bizflow::DomainIncubator

  attr_accessor :repo, :process_incubator

  def initialize(repo)

    @domain = nil
    @process_incubator = nil
    @repo = repo

  end

  def process(name, &block)
    @process_incubator = Bizflow::ProcessIncubator.new(name)
    process_incubator.instance_eval(&block)
    repo.add_process(process_incubator.process)
  end


end