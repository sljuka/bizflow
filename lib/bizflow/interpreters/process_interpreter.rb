require "bizflow/interpreters/task_action_interpreter"
require "bizflow/interpreters/automated_action_interpreter"
require "bizflow/domain/process"

class Bizflow::ProcessInterpreter

  attr_accessor :process, :task_action_interpreter, :automated_action_interpreter

  def initialize(process_name)
    @process = Bizflow::Domain::Process.new(process_name)
  end

  def automated_action(name, &action)
    automated_action_interpreter = Bizflow::AutomatedActionInterpreter.new(name)
    automated_action_interpreter.instance_eval(&action)
    process.add_action(automated_action_interpreter.action)
  end

  def task_action(name, &action)
    task_action_interpreter = Bizflow::TaskActionInterpreter.new(name)
    task_action_interpreter.instance_eval(&action)
    process.add_action(task_action_interpreter.action)
  end

  def description(description)
    process.description = description
  end

  def start_action(action_name)
    process.start_action = action_name
  end

end