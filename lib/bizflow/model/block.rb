require 'data_mapper'

module Bizflow
  module Model
    class Block
      
      include DataMapper::Resource

      def self.default_repository_name
        :bfdb
      end

      property :id, Serial
      property :type, String, :required => true

      belongs_to :process
      has n, :process_heads

    end
  end
end
