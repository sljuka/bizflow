require "bizflow/domain_model/block"

class Bizflow::TaskBlock < Bizflow::Block

  attr_accessor :name, :description, :tasks, :next_block

  def initialize(name)
    super
    @tasks = []
    @next_block 
  end

  def add_task(task)
    tasks << task
  end

end