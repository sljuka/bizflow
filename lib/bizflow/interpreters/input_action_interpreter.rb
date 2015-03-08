
require "bizflow/semantic_model/input_action"
require "bizflow/semantic_model/handler"

class Bizflow::InputActionInterpreter

  attr_accessor :action

  def initialize(name)
    @action = Bizflow::SemanticModel::InputAction.new(name)
  end

  def description(description)
    action.description = description
  end

  def handler(name, options = {})
    raise "handler for action already defined" if action.handler
    action.handler = Bizflow::SemanticModel::Handler.new(name, options)
  end

  def next_actions(actions_hash)
    raise "next actions already defined" if !action.next_actions.empty?
    action.next_actions = actions_hash
  end

end