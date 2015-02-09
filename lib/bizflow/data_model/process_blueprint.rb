require 'sequel'

module Bizflow

  module DataModel

    class ProcessBlueprint

      one_to_many :processes
      one_to_many :action_blueprints

    end

  end

end

