require 'delegate'
require 'bizflow/monkey_patch'

class Bizflow::ProcessTemplatePresenter < SimpleDelegator

  def render_dependencies

  end

  def render_comment_header

  end

  def get_binding
    binding
  end

  def classy_name(name)
    name.camelcase_notation
  end

  def render_automated_block(block)
    render = "#{block.name}: {\n"
    render += "handler: Handlers::#{classy_name(block.handler.namespace)}::#{classy_name(block.handler.name)}\n"
    render += "},"
    render
  end

  def render_task_block(block)

  end

  def all_tasks
    tasks = []
    task_blocks.each do |_, ab|
      tasks += ab.tasks
    end
    tasks
  end

end
