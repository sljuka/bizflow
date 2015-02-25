require 'sequel'

module Bizflow

  module DataModel

    class TaskBlueprint < Sequel::Model

      one_to_many :tasks
      many_to_one :action_blueprint

    end

  end

end

