
module Bizflow
  module Model
    class Process
      
      include DataMapper::Resource

      def self.default_repository_name
        :bfdb
      end

      property :id, Serial
      property :type, String, :required => true
      property :creator_id, Integer, :required => true
      property :runner_id, Integer
      property :created_at, DateTime
      property :runned_at, DateTime
      property :jumped_at, DateTime

      has n, :blocks

    end
  end
end
