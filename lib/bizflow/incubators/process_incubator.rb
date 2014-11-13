require "bizflow/incubators/task_block_incubator"
require "bizflow/incubators/automated_block_incubator"
require "bizflow/domain_model/process"

class Bizflow::ProcessIncubator

  attr_accessor :process, :repo, :task_block_incubator, :automated_block_incubator

  def initialize(process_name)

    @process = Bizflow::Process.new(process_name)

  end

  def automated_block(name, &block)
    automated_block_incubator = Bizflow::AutomatedBlockIncubator.new(name)
    automated_block_incubator.instance_eval(&block)
    @process.add_automated_block(automated_block_incubator.block)
  end

  def task_block(name, &block)
    task_block_incubator = Bizflow::TaskBlockIncubator.new(name)
    task_block_incubator.instance_eval(&block)
    @process.add_task_block(task_block_incubator.block)
  end

  def description(description)
    @process.description = description
  end

  def namespace(namespace)
    @process.namespace = namespace
  end

  def start_block(block_name)
    @process.start_block = block_name
  end

  def roles(roles_array)
    @process.roles = roles_array
  end

end