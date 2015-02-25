require 'sequel'

module Bizflow

  module DataModel

    class Process

      many_to_one :process_blueprint
      one_to_many :actions
      one_to_many :heads
      many_to_one :start, :class => :Action

    end

  end

end

