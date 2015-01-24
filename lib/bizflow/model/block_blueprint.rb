require 'sequel'

module Bizflow

  module Model

    class BlockBlueprint < Sequel::Model

      many_to_one :process_blueprint
      one_to_many :handler_blueprints
      one_to_many :task_blueprints
      one_to_many :blocks


    end

  end

end

