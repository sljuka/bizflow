require "sqlite3"
require 'sequel'
require 'fileutils'
require 'pathname'

module Bizflow
  class SetupCommand

    def self.run(config, args)

      Sequel.extension :migration, :core_extensions

      # Create a database
      puts "Creating and migrating database for processes..."

      db_path = config[:db_path] || "bizflow_db/bf.db"
      db_path = "#{Dir.pwd}/#{db_path}"

      pn = Pathname.new(db_path)
      FileUtils::mkdir_p pn.dirname.to_s

      db = Sequel.sqlite(db_path)

      Sequel::Migrator.run(db, File.expand_path("#{File.expand_path(File.dirname(__FILE__))}/../migrations"), :use_transactions=>true)
      puts "Database setup"
    end

  end
end
