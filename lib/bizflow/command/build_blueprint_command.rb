require "sqlite3"
require 'sequel'

module Bizflow
  class BuildBlueprintCommand

    def self.run(config, args)

      puts "Building processes"

      source_path = "#{config[:source_path]}" || "#{Dir.pwd}/#{args[0]}"
      db = Bizflow::DomainBuilder.new(source_path)

      domain_repo = db.build

      domain_repo.processes.each do |p|
        data_process = Bizflow::Model::ProcessBlueprint.create(name: p.name, description: p.description)
        create_block_blueprints(data_process, p)
      end

      puts "Processes built"

    end

    private

    def self.create_block_blueprints(data_process, process)
      process.blocks.each do |b|
        data_block = data_process.add_block_blueprint(type: b.type, name: b.name, description: b.description)
        create_task_blueprints(data_block, b)
        create_handler_blueprints(data_block, b)
      end
    end

    def self.create_task_blueprints(data_block, block)
      return if block.type == "auto"
      block.tasks.each do |t|
        data_block.add_task_blueprint(name: t.name, roles: t.roles.join(" "), description: t.description, auto_assign: t.auto_assign)
      end
    end

    def self.create_handler_blueprints(data_block, block)
      return if block.type == "task"
      data_block.add_handler_blueprint(path: block.handler.name, constant: block.handler.namespace, description: block.handler.description)
    end

  end
end
