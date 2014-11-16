require "bizflow/interpreters/process_interpreter"


class Bizflow::DomainInterpreter

  attr_accessor :repo, :process_interpreter

  def initialize(repo)

    @domain = nil
    @process_interpreter = nil
    @repo = repo

  end

  def process(name, &block)
    @process_interpreter = Bizflow::ProcessInterpreter.new(name)
    process_interpreter.instance_eval(&block)
    repo.add_process(process_interpreter.process)
  end


end