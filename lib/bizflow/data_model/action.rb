require 'sequel'

module Bizflow

  module DataModel

    class Action < Sequel::Model

      one_to_many :tasks
      one_to_many :heads
      one_to_many :handlers
      many_to_one :process
      many_to_one :action_blueprint

      one_to_many :next_actions
      many_to_many :actions, :join_table => :next_actions

    end

  end

end
