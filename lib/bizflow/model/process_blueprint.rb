require 'sequel'

module Bizflow

  module Model

    class ProcessBlueprint < Sequel::Model

      one_to_many :processes
      one_to_many :block_blueprints

    end

  end

end

