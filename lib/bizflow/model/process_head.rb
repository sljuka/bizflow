require 'sequel'

module Bizflow

  module Model

    class ProcessHead < Sequel::Model

      many_to_one :block
      many_to_one :process

    end

  end

end
