require "sqlite3"
require "data_mapper"
require_relative "../model/process"
require_relative "../model/process_head"
require_relative "../model/block"
require_relative "../model/task"



module Bizflow

  class Repo

    Tables = {
      processes: Bizflow::Model::Process,
      process_heads: Bizflow::Model::ProcessHead,
      blocks: Bizflow::Model::Block,
      tasks: Bizflow::Model::Task
    }

    def create(table_name, hash)
      Tables[table_name.to_sym].create(hash)
    end

    def read(table_name, where_hash = nil, where_statement = nil)
      if(where_hash)
        Tables[table_name.to_sym].all(where_hash)
      else
        Tables[table_name.to_sym].all
      end
    end

    def update(table_name, id, hash)
      Tables[table_name.to_sym].get(id).update(hash)
    end

    def delete(table_name, ids)
      Tables[table_name.to_sym].all(id: ids).destroy
    end

  end

end