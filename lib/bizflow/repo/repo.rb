require "sqlite3"
require 'sequel'
require 'bizflow/business_model/process'

module Bizflow

  class Repo

    def initialize
      puts "connecting to #{db_path}"
      Sequel.connect("sqlite://#{db_path}")
      Dir[File.expand_path("../../data_model/*.rb", __FILE__)].each { |file| require_relative file }
    end 

    def create_process(blueprint_id, creator_id)
      pbp = Bizflow::DataModel::ProcessBlueprint[blueprint_id]
      raise "no process with id '#{blueprint_id}'" unless pbp

      p = Bizflow::DataModel::Process.create(
        name: pbp.name,
        description: pbp.description,
        creator_id: creator_id,
        process_blueprint: pbp
      )
      
      pbp.action_blueprints.each do |bp|
        a = Bizflow::DataModel::Action.create(name: bp.name, type: bp.type, process: p, action_blueprint: bp)
        puts (pbp.start == a.name) ? "true" : "false"
        p.update(start_id: a.id) if pbp.start == a.name
      end

      h = Bizflow::DataModel::Head.create(process: p)

      Bizflow::BusinessModel::Process.new p
    end

    def process_blueprints
      Bizflow::DataModel::ProcessBlueprint.all
    end

    def processes
      Bizflow::DataModel::Process.all
    end

    def find_process(id)
      p = Bizflow::DataModel::Process[id]
      Bizflow::BusinessModel::Process.new p
    end

    def tasks(user_id = nil)
      if user_id
        Bizflow::DataModel::Task.where(assignee_id: user_id)
      else
        Bizflow::DataModel::Task.all
      end
    end

  end

end