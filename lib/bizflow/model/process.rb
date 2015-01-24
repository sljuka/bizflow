require 'sequel'

module Bizflow

  module Model

    class Process < Sequel::Model

      many_to_one :process_blueprint
      one_to_many :blocks
      one_to_many :process_heads

    end

  end

end

