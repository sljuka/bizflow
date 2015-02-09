require 'sequel'

module Bizflow

  module DataModel

    class HandlerBlueprint

      many_to_one :action_blueprint
      one_to_many :handlers

    end

  end

end

