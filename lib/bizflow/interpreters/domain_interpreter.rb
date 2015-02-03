require "bizflow/interpreters/process_interpreter"


class Bizflow::DomainInterpreter

  attr_accessor :repo, :process_interpreter

  def initialize(repo)
    @repo = repo
  end

  def process(name, &action)
    process_interpreter = Bizflow::ProcessInterpreter.new(name)
    process_interpreter.instance_eval(&action)
    repo.add_process(process_interpreter.process)
  end


end