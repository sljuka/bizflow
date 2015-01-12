require "sqlite3"
require "data_mapper"
require_relative "../model/process_model"

module Bizflow

  class Repo

    attr_accessor :db

    def initialize(db_path)
      DataMapper.setup(:default, "sqlite://#{db_path}/bizflow_db/bf.db")
      DataMapper.auto_migrate!
      puts "1"
    end

    def create(table_name, hash)
      puts "2"
      pm = ProcessModel.new(type: "bla", val: 12)
      pm.save
      ProcessModel.all

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