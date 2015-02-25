require "sqlite3"
require 'sequel'
require 'bizflow/domain_builder'

module Bizflow
  class BuildCommand

    def self.run(config, args)

      puts "Building processes"

      args_path = nil
      args_path = "#{Dir.pwd}/#{args[0]}" if(args && args[0])

      source_path = args_path || "#{config[:source_path]}"
      db = Bizflow::DomainBuilder.new(source_path)

      domain_repo = db.build

      raise if config[:db_path].nil?
      db_path = "#{Dir.pwd}/#{config[:db_path]}"
      db = Sequel.sqlite(db_path)

      Dir["#{File.dirname(__FILE__)}/../model/*.rb"].each { |path| require_relative path }
      domain_repo.processes.each do |p|
        data_process = Bizflow::Model::ProcessBlueprint.create(
          name: p.name,
          description: p.description,
          start: p.start)

        create_action_blueprints(data_process, p)
      end

      puts "Processes built"

    end

    private

    def self.create_action_blueprints(data_process, process)
      process.actions.each do |b|
        data_action = data_process.add_action_blueprint(type: b.type, name: b.name, description: b.description)
        create_task_blueprints(data_action, b)
        create_handler_blueprints(data_action, b)
      end
    end

    def self.create_task_blueprints(data_action, action)
      return if action.type == "auto"
      action.tasks.each do |t|
        data_action.add_task_blueprint(name: t.name, roles: t.roles.join(" "), description: t.description, auto_assign: t.auto_assign)
      end
    end

    def self.create_handler_blueprints(data_action, action)
      return if action.type == "task"
      data_action.add_handler_blueprint(name: action.handler.name, namespace: action.handler.namespace, description: action.handler.description)
    end

  end
end