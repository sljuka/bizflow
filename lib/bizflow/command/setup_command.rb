require "sqlite3"
require 'sequel'
require 'fileutils'
require 'pathname'

module Bizflow
  class SetupCommand

    def self.run(config, args)

      # Create a database
      puts "Bizflow: Creating and migrating database for processes..."

      db_path = config[:db_path] || "bizflow_db/bf.db"
      db_path = "#{Dir.pwd}/#{db_path}"

      pn = Pathname.new(db_path)
      FileUtils::mkdir_p pn.dirname.to_s

      db = Sequel.sqlite(db_path)

      puts "Bizflow: Database setup"
    end

  end
end
