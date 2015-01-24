require 'sequel'

module Bizflow

  module Model

    class Block < Sequel::Model

      one_to_many :tasks
      one_to_many :process_heads
      many_to_one :process

    end

  end

end
