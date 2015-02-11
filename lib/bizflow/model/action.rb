require 'sequel'
require_relative 'action'

module Bizflow

  module Model

    class Action < Sequel::Model

      one_to_many :tasks
      one_to_many :heads
      one_to_many :handlers
      many_to_one :process
      many_to_one :action_blueprint

    end

  end

end
