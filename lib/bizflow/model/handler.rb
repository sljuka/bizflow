require 'sequel'

module Bizflow

  module Model

    class Handler < Sequel::Model

      many_to_one :action

    end

  end

end

