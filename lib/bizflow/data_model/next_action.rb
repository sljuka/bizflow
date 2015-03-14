require 'sequel'

module Bizflow

  module DataModel

    class NextAction < Sequel::Model

      many_to_one :action
      many_to_one :next, :class => :'Bizflow::DataModel::Action'
      
    end

  end

end

