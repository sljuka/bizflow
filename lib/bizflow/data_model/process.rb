require 'sequel'

module Bizflow

  module DataModel

    class Process < Sequel::Model

      many_to_one :process_blueprint
      one_to_many :actions
      one_to_many :heads
      one_to_one :start, :class => :'Bizflow::DataModel::Action'

      def human_name
      	name.humanize
      end

    end

  end

end

