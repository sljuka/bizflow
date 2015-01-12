require "sqlite3"
require "data_mapper"
require "bizflow/model/process_model"

module Bizflow
  class SetupDbCommand

    def self.run(config, args)
      # Open a database
      puts "seting up database"
      DataMapper.setup(:bfdb, "sqlite://#{Dir.pwd}/bizflow_db/bfa.db")
      DataMapper.finalize
      DataMapper.repository(:bfdb).auto_migrate!
      puts "database setup"
    end

  end
end
