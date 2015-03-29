require "sqlite3"
require 'sequel'
require 'bizflow/business_model/process'
require 'bizflow/lib/process_builder'

module Bizflow
  module Repos
  
    class Repo

      def initialize
        Sequel.connect("sqlite://#{db_path}")
        Dir[File.expand_path("../../data_model/*.rb", __FILE__)].each { |file| require_relative file }
      end

      def create_process(blueprint_id, creator_id)
        Bizflow::Lib::ProcessBuilder.new.build(blueprint_id, creator_id)
      end

      def process_blueprints
        Bizflow::DataModel::ProcessBlueprint.all
      end

      def processes(names = [])
        if names && !names.empty?
          {
            blueprints: Bizflow::DataModel::ProcessBlueprint.where(name: names).select_group(:name).select_append { max(id).as(latest) }.all,
            processes: Bizflow::DataModel::Process.where(name: names).all
          }
        else
          {
            blueprints: Bizflow::DataModel::ProcessBlueprint.select_group(:name).select_append { max(id).as(latest) }.all, 
            processes: Bizflow::DataModel::Process.all
          }
        end
      end

      def run_process(id, user_id)
        p = Bizflow::DataModel::Process[id]
        p = Bizflow::BusinessModel::Process.wrap p
        p.run(user_id)
      end

      def find_process(id)
        p = Bizflow::DataModel::Process[id]
        Bizflow::BusinessModel::Process.wrap p
      end

      def tasks(user_id = nil, active = true)
        if user_id
          Bizflow::DataModel::Task.where(assignee_id: user_id)
        else
          Bizflow::DataModel::Task.all
        end
      end

      def db_path
        raise NotImplementedError
      end

    end

  end
end