require 'sequel'

module Bizflow

  module Model

    class Process < Sequel::Model

      many_to_one :process_blueprint
      one_to_many :actions
      one_to_many :heads

    end

  end

end

