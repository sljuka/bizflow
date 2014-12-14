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

  def process_roles_list
    roles.map{|r| "\"#{r}\""}.join(", ")
  end

end
