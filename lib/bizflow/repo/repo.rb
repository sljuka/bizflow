require "sqlite3"
require 'sequel'
require 'bizflow/business/process'

module Bizflow

  class Repo

    def initialize
      puts "connecting to #{db_path}"
      Sequel.connect("sqlite://#{db_path}")
      Dir[File.expand_path("../../model/*.rb", __FILE__)].each { |file| require_relative file }
    end 

    def create_process(blueprint_id, creator_id)
      pbp = Bizflow::Model::ProcessBlueprint[blueprint_id]
      raise "no process with id '#{blueprint_id}'" unless pbp

      p = Bizflow::Model::Process.create(name: pbp.name, description: pbp.description, creator_id: creator_id)
      
      pbp.action_blueprints.each do |bp|
        a = Bizflow::Model::Action.create(name: bp.name, type: bp.type, process: p, action_blueprint: bp)
        p.update(start_action: a) if pbp.start_action == a.name && p.start_action.nil?
      end

      h = Bizflow::Model::Head.create(process: p)

      Bizflow::Business::Process.new p
    end

    def process_blueprints
      Bizflow::Model::ProcessBlueprint.all
    end

    def db_path
      raise NotImplementedError
    end

  end

end