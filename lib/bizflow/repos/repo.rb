# require "sqlite3"
require 'sequel'

module Bizflow
  module Repos
  
    class Repo

      def self.connect(db_path)
        @@connection ||= Sequel.connect("sqlite://#{db_path}")
        Dir[File.expand_path("../../data_model/*.rb", __FILE__)].each { |file| require_relative file }
      end

      def self.connection
        @@connection
      end

    end

  end
end