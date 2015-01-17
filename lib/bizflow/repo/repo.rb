require "sqlite3"
require 'sequel'

module Bizflow

  class Repo

    def initialize
      puts "connecting to #{db_path}"
      Sequel.connect("sqlite://#{db_path}")
      require_relative "../model/process"
      require_relative "../model/process_head"
      require_relative "../model/block"
      require_relative "../model/task"
    end 

    def create(table_name, hash)
      db_tables[table_name.to_sym].create(hash)
    end

    def read(table_name, where_hash = nil, where_statement = nil)
      puts db_tables[table_name.to_sym]
      if(where_hash)
        db_tables[table_name].all(where_hash)
      else
        db_tables[table_name].all
      end
    end

    def update(table_name, id, hash)
      db_tables[table_name.to_sym].get(id).update(hash)
    end

    def delete(table_name, ids)
      db_tables[table_name.to_sym].all(id: ids).destroy
    end

    def db_tables
      {
        processes: Bizflow::Model::Process,
        process_heads: Bizflow::Model::ProcessHead,
        blocks: Bizflow::Model::Block,
        tasks: Bizflow::Model::Task
      }
    end

    def db_path
      raise NotImplementedError
    end

  end

end