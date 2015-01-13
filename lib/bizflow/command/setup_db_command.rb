require "sqlite3"
require "data_mapper"
require "bizflow/model/process"
require "bizflow/model/process_head"
require "bizflow/model/task"
require "bizflow/model/block"

module Bizflow
  class SetupDbCommand

    def self.run(config, args)
      # Open a database
      puts "seting up database"
      adapter = DataMapper.setup(:bfdb, "sqlite://#{Dir.pwd}/bizflow_db/bfa.db")
      adapter.resource_naming_convention = DataMapper::NamingConventions::Resource::UnderscoredAndPluralizedWithoutModule
      DataMapper.finalize
      DataMapper.repository(:bfdb).auto_migrate!
      puts "database setup"
    end

  end
end
