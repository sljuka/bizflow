require 'sequel'
require_relative 'action'

module Bizflow

  module Model

    class Process < Sequel::Model

      many_to_one :process_blueprint
      one_to_many :actions
      one_to_many :heads
      one_to_one :start_action, :class => :'Bizflow::Model::Action'

    end

  end

end

