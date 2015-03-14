require 'sequel'

module Bizflow

  module DataModel

    class NextActionBlueprint < Sequel::Model

      many_to_one :action_blueprint
      many_to_one :next_blueprint, :class => :'Bizflow::DataModel::ActionBlueprint'
      
    end

  end

end

