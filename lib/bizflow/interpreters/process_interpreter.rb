require "bizflow/interpreters/task_block_interpreter"
require "bizflow/interpreters/automated_block_interpreter"
require "bizflow/domain/process"

class Bizflow::ProcessInterpreter

  attr_accessor :process, :task_block_interpreter, :automated_block_interpreter

  def initialize(process_name)
    @process = Bizflow::Domain::Process.new(process_name)
  end

  def automated_block(name, &block)
    automated_block_interpreter = Bizflow::AutomatedBlockInterpreter.new(name)
    automated_block_interpreter.instance_eval(&block)
    process.add_block(automated_block_interpreter.block)
  end

  def task_block(name, &block)
    task_block_interpreter = Bizflow::TaskBlockInterpreter.new(name)
    task_block_interpreter.instance_eval(&block)
    process.add_block(task_block_interpreter.block)
  end

  def description(description)
    process.description = description
  end

  def start_block(block_name)
    process.start_block = block_name
  end

end