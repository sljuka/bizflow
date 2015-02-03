require 'sequel'

module Bizflow

  module Model

    class ProcessHead < Sequel::Model

      many_to_one :action
      many_to_one :process

    end

  end

end
