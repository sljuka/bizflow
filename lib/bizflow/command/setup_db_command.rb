require "sqlite3"
require 'sequel'

module Bizflow
  class SetupDbCommand

    def self.run(config, args)

      Sequel.extension :migration, :core_extensions

      # Create a database
      puts "Creating and migrating database for processes"
      db_path = config[:db_path] || "#{Dir.pwd}/bizflow_db/bf.db"
      db = Sequel.sqlite(db_path)
      Sequel::Migrator.run(db, File.expand_path("#{File.expand_path(File.dirname(__FILE__))}/../migrations"), :use_transactions=>true)
      puts "Database setup"
    end

  end
end
