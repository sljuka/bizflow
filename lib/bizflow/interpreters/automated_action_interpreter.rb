
require "bizflow/domain/automated_action"
require "bizflow/domain/handler"

class Bizflow::AutomatedActionInterpreter

  attr_accessor :action

  def initialize(name)
    @action = Bizflow::Domain::AutomatedAction.new(name)
  end

  def description(description)
    action.description = description
  end

  def handler(name, options = {})
    raise "handler for action already defined" if action.handler
    action.handler = Bizflow::Domain::Handler.new(name, options)
  end

  def next_actions(actions_hash)
    raise "next actions already defined" if !action.next_actions.empty?
    action.next_actions = actions_hash
  end

end