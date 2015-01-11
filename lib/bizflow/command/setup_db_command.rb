require "sqlite3"

module Bizflow
  class SetupDbCommand

    def self.run(config, args)
      # Open a database
      Dir.mkdir("#{Dir.pwd}/bizflow_db") if Dir["#{Dir.pwd}/bizflow_db"].empty?
      db = SQLite3::Database.new "#{Dir.pwd}/bizflow_db/bf.db"
      db.results_as_hash = true

      # Create a database
      db.execute <<-SQL
        create table processes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          process_type varchar(30),
          val int
        );
      SQL

      db.execute <<-SQL
        create table blocks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name varchar(30),
          val int
        );
      SQL

      db.execute <<-SQL
        create table tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name varchar(30),
          val int
        );
      SQL

      # Execute a few inserts  
      db.execute( "INSERT INTO processes ( process_type, val ) VALUES ( ?, ? )", ["order_type", 5])
      db.execute( "INSERT INTO processes ( process_type, val ) VALUES ( ?, ? )", ["order_type2", 2])
    
      # Find a few rows
      db.execute( "select * from processes" ) do |r|
        puts r
      end
    end

  end
end
