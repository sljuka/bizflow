require "sqlite3"
require 'sequel'

module Bizflow
  class SetupDbCommand

    def self.run(config, args)

      Sequel.extension :migration, :core_extensions

      # Create a database
      puts "Creating and migrating database for processes"
      db = Sequel.sqlite("#{Dir.pwd}/bizflow_db/bf.db")
      Sequel::Migrator.run(db, File.expand_path("#{File.expand_path(File.dirname(__FILE__))}/../migrations"), :use_transactions=>true)
      puts "Database setup"
    end

  end
end
