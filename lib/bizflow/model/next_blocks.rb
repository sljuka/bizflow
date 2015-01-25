require 'sequel'

module Bizflow

  module Model

    class NextBlock < Sequel::Model

      many_to_one :block_blueprint
      many_to_one :next_block_blueprint, :class => :BlockBlueprint
      
    end

  end

end
