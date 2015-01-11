require "sqlite3"

module Bizflow

  class BfRepo

    attr_accessor :db

    def initialize(db_path)
      @db = SQLite3::Database.new "#{db_path}/bizflow_db/bf.db"
      @db.results_as_hash = true
    end

    def create(table_name, hash)
      attributes = hash.keys.map(&:to_s).join(", ")
      res = []

      query = <<-SQL
        INSERT INTO #{table_name} ( #{attributes} ) VALUES ( ?, ? );
      SQL

      db.execute(query, hash.values)
      id = db.last_insert_row_id
      read(table_name, id: id)
    end

    def read(table_name, where_hash = nil, where_statement = nil)

      where_part = ""

      if where_hash
        statement = where_hash.map do |k, v|
          "#{k} = #{v.is_a?(String) ? 'v' : v}"
        end.join(" AND ")
        where_part = "WHERE #{statement}"
      end

      if where_statement
        where_part = "WHERE #{where_statement}"
      end

      query = <<-SQL
      SELECT * FROM #{table_name}
      #{where_part}
      SQL

      res = []
      db.execute query do |r|
        res += [r]
      end

      res
    end

    def update(table_name, id, hash)
      
      set_statement = hash.map do |k, v|
        "#{k} = #{v.is_a?(String) ? 'v' : v}"
      end.join(", ")

      db.execute <<-SQL
      UPDATE #{table_name}
      SET #{set_statement}
      WHERE id = #{id}
      SQL

      read(table_name, id: id)
    end

    def delete(table_name, ids)
      res = read(table_name, id: id)
      db.execute <<-SQL
      DELETE FROM #{table_name}
      WHERE id IN (#{ids.join(", ")});
      SQL
      res
    end

    def sql(sql)
      db.execute sql
    end

  end

end