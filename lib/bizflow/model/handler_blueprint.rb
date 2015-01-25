require 'sequel'

module Bizflow

  module Model

    class HandlerBlueprint < Sequel::Model

      many_to_one :block_blueprint
      one_to_many :handlers
      

    end

  end

end

