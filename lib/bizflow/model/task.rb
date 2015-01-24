require 'sequel'

module Bizflow

  module Model

    class Task < Sequel::Model

      many_to_one :block

    end

  end

end

