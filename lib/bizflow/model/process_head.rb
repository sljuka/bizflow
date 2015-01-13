require 'data_mapper'

module Bizflow
  module Model
    class ProcessHead
      
      include DataMapper::Resource

      def self.default_repository_name
        :bfdb
      end

      property :id, Serial

      belongs_to :process
      belongs_to :block

    end
  end
end
