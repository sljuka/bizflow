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
          process_type varchar(30),
          val int
        );
      SQL

      db.execute <<-SQL
        create table blocks (
          name varchar(30),
          val int
        );
      SQL

      db.execute <<-SQL
        create table tasks (
          name varchar(30),
          val int
        );
      SQL

      # Execute a few inserts
      {
        "one" => 1,
        "two" => 2,
      }.each do |pair|
        db.execute "insert into processes values ( ?, ? )", pair
      end

      # Find a few rows
      db.execute( "select * from processes" ) do |r|
        puts r
      end
    end

  end
end
