require "sqlite3"
require 'sequel'
require 'bizflow/external/automated_action'
require 'bizflow/external/process_head'
require 'bizflow/external/task'
require 'bizflow/external/task_action'
require 'bizflow/external/business_process'

module Bizflow

  class Repo

    def initialize
      puts "connecting to #{db_path}"
      Sequel.connect("sqlite://#{db_path}")
      Dir["../model/*.rb"].each { |file| require_relative file }
    end 

    def create(table_name, hash)
      db_tables[table_name.to_sym].create(hash)
    end

    def read(table_name, where_hash = nil, where_statement = nil)
      puts db_tables[table_name.to_sym]
      res = nil
      if(where_hash)
        res = db_tables[table_name].all(where_hash)
      else
        res = db_tables[table_name].all
      end
      wrap(table_name, res)
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
        actions: Bizflow::Model::Action,
        tasks: Bizflow::Model::Task
      }
    end

    def db_wrappers
      {
        processes: Bizflow::BusinessProcess,
        process_heads: Bizflow::ProcessHead,
        actions: {
          auto: Bizflow::AutomatedAction,
          task: Bizflow::TaskAction
        },
        tasks: Bizflow::Task
      }
    end

    def db_path
      raise NotImplementedError
    end

    def wrap(table_name, models)
      wrapper = nil
      if table_name == :actions
        wrapper = db_wrappers[table_name][model.type]
      else
        wrapper = db_wrappers[table_name]
      end

      wrapper.wraps(models)

    end

  end

end