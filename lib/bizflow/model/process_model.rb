require 'data_mapper'

module Bizflow
  class ProcessModel
    include DataMapper::Resource

    def self.default_repository_name
      :bfdb
    end

    property :id, Serial
    property :type, String, :required => true
    property :val, Integer, :required => true

  end
end
