class Bizflow::TaskBlock

  attr_accessor :name, :description, :tasks, :next_block

  def initialize(name, description = nil)
    @name = name
    @description = description
    @tasks = []
  end

  def add_task(task)
    tasks << task
  end

end