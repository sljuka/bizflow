require 'sequel'

module Bizflow

  module DataModel

    class ActionBlueprint < Sequel::Model

      many_to_one :process_blueprint
      one_to_many :handler_blueprints
      one_to_many :task_blueprints
      one_to_many :actions

      one_to_many :next_action_blueprints
      many_to_many :action_blueprints, :join_table => :next_action_blueprints

    end

  end

end

