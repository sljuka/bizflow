require 'sequel'

module Bizflow

  module DataModel

    class Handler < Sequel::Model

      many_to_one :action

    end

  end

end

