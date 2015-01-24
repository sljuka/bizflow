require 'sequel'

module Bizflow

  module Model

    class Block < Sequel::Model

      one_to_many :tasks
      one_to_many :process_heads
      one_to_many :handlers
      many_to_one :process
      many_to_one :block_blueprint

    end

  end

end
