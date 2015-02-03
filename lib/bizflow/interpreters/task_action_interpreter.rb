
require "bizflow/domain/task_action"
require "bizflow/domain/task"

class Bizflow::TaskActionInterpreter

  attr_accessor :action

  def initialize(name)
    @action = Bizflow::Domain::TaskAction.new(name)
  end

  def next_action(name)
    action.next_action = name
  end

  def description(description)
    action.description = description
  end

  def task(name, options)
    action.add_task(Bizflow::Domain::Task.new(name, options))
  end

end