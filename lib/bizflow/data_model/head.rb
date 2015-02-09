require 'sequel'

module Bizflow

  module DataModel

    class Head

      many_to_one :action
      many_to_one :process

    end

  end

end
