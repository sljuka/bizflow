require "sqlite3"
require 'sequel'
require 'fileutils'
require 'pathname'

module Bizflow
  class SetupCommand

    def self.run(config, args)

      if(args[:args].empty?)
        raise "Setup command needs environment argument (production, development, test...)"
      end
      environment = args[:args].first

      Sequel.extension :migration, :core_extensions

      # Create a database
      puts "Bizflow: Creating and migrating database for processes..."

      db_path = "bizflow_db/bf-#{environment}.db"
      db_path = "#{Dir.pwd}/#{db_path}"

      pn = Pathname.new(db_path)
      FileUtils::mkdir_p pn.dirname.to_s

      db = Sequel.sqlite(db_path)

      Sequel::Migrator.run(db, File.expand_path("#{File.expand_path(File.dirname(__FILE__))}/../migrations"), :use_transactions=>true)

      puts "Bizflow: #{environment} database setup"
    end

  end
end
