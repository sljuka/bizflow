require 'data_mapper'

module Bizflow
  module Model
    class Task
      
      include DataMapper::Resource

      def self.default_repository_name
        :bfdb
      end

      property :id, Serial
      property :name, String, :required => true
      property :created_at, DateTime
      property :finished_at, DateTime
      property :assignee_id, Integer
      property :auto_assigned, Boolean, :default => false

      belongs_to :block

    end
  end
end
