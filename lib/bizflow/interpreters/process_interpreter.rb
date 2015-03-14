require "bizflow/interpreters/task_action_interpreter"
require "bizflow/interpreters/input_action_interpreter"
require "bizflow/semantic_model/process"

class Bizflow::ProcessInterpreter

  attr_accessor :process, :task_action_interpreter, :input_action_interpreter

  def initialize(process_name)
    @process = Bizflow::SemanticModel::Process.new(process_name)
  end

  def input_action(name, &action)
    input_action_interpreter = Bizflow::InputActionInterpreter.new(name)
    input_action_interpreter.instance_eval(&action)
    process.add_action(input_action_interpreter.action)
  end

  def task_action(name, &action)
    task_action_interpreter = Bizflow::TaskActionInterpreter.new(name)
    task_action_interpreter.instance_eval(&action)
    process.add_action(task_action_interpreter.action)
  end

  def handler_action(name, &action)

  end

  def description(description)
    process.description = description
  end

  def start(action_name)
    process.start = action_name
  end

end