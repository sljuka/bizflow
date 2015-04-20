
require "bizflow/semantic_model/task_action"
require "bizflow/semantic_model/task"

class Bizflow::TaskActionInterpreter

  attr_accessor :action

  def initialize(name)
    @action = Bizflow::SemanticModel::TaskAction.new(name)
  end

  def next_action(name)
    action.next_action = name
  end

  def description(description)
    action.description = description
  end

  def task(name, options)
    action.add_task(Bizflow::SemanticModel::Task.new(name, options))
  end

  def input_task(name, options)
    task(name, options)
  end

end