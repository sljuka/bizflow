require "sqlite3"
require 'sequel'
require 'bizflow/business_model/process'
require 'bizflow/lib/process_builder'

module Bizflow
  module Repos
  
    class Repo

      attr_reader :connection

      def initialize
        @connection = Sequel.connect("sqlite://#{db_path}")
        Dir[File.expand_path("../../data_model/*.rb", __FILE__)].each { |file| require_relative file }
      end

      def create_process(blueprint_id, creator_id)
        Bizflow::Lib::ProcessBuilder.new.build(blueprint_id, creator_id)
      end

      def blueprints
        Bizflow::DataModel::ProcessBlueprint
      end

      def processes
        Bizflow::DataModel::Process
      end

      def run_process(id, user_id)
        p = Bizflow::DataModel::Process[id]
        p = Bizflow::BusinessModel::Process.wrap p
        p.run(user_id)
      end

      def tasks
        Bizflow::DataModel::Task
      end

      def actions
        Bizflow::DataModel::Action
      end

      def db_path
        raise NotImplementedError
      end

    end

  end
end