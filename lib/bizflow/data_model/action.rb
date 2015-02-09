require 'sequel'

module Bizflow

  module DataModel

    class Action

      attr_accessor :name, :type, :process, :action_blueprint, :next_actions, :tasks, :handlers

    end

  end

end

# a = Action.new
# a.set(name: "asdf", type: "task")
# a.tasks.add(name: "sss", description: "fff")