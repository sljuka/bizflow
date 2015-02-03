require 'sequel'

module Bizflow

  module Model

    class TaskBlueprint < Sequel::Model

      one_to_many :tasks
      many_to_one :action_blueprint

    end

  end

end

