require "sqlite3"
require 'sequel'
require 'fileutils'
require 'pathname'

module Bizflow
  class MigrateCommand

    def self.run(config, args)

      if(args[:args].empty?)
        raise "Setup command needs environment argument (production, development, test...)"
      end
      environment = args[:args].first

      Sequel.extension :migration, :core_extensions

      puts "Bizflow: Migrating database"
      db_path = config[:db_path] || "bizflow_db"
      db_path = "#{Dir.pwd}/#{db_path}/bf-#{environment}.db"

      puts db_path
      db = Sequel.sqlite(db_path)

      Sequel::Migrator.run(db, File.expand_path("#{File.expand_path(File.dirname(__FILE__))}/../migrations"), :use_transactions=>true)
      puts "Bizflow: Database bf-#{environment}.db migrated"

    end
  end
end