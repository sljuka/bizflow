require 'sequel'

module Bizflow

  module Model

    class NextAction < Sequel::Model

      many_to_one :action_blueprint
      many_to_one :next_action_blueprint, :class => :ActionBlueprint
      
    end

  end

end

