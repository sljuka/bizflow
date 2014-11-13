class Bizflow::Process

  attr_accessor :name, :description, :namespace, :start_block, :roles, :automated_blocks, :task_blocks

  def initialize(name)
    @name = name
    @automated_blocks = {}
    @task_blocks = {}
    @roles = []
  end

  def add_automated_block(block)
    @automated_blocks[block.name.to_sym] = block
  end

  def add_task_block(block)
    @task_blocks[block.name.to_sym] = block
  end

end