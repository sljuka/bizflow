require "sqlite3"
require 'sequel'

Dir["#{File.dirname(__FILE__)}/../model/*.rb"].each { |file| require_relative file }

module Bizflow
  class SetupDbCommand

    def self.run(config, args)

      Sequel.extension :migration, :core_extensions

      # Create a database
      puts "Creating and migrating database for processes"
      db = Sequel.sqlite("#{Dir.pwd}/bizflow_db/bf.db")
      Sequel::Migrator.run(db, File.expand_path("#{File.expand_path(File.dirname(__FILE__))}/../migrations"), :use_transactions=>true)

      source_path = "#{Dir.pwd}/#{config[:source_path]}" || "#{Dir.pwd}/#{args[0]}"
      db = Bizflow::DomainBuilder.new(source_path)

      domain_repo = db.build

      domain_repo.processes.each do |p|

        Bizflow::Model::ProcessBlueprint.create(name: p.name, description: p.description)

        create_block_blueprints(p)

      end

      puts "built new blueprint"

    end

    private

    def create_block_blueprints(process)
      process.blocks.values.each do |b|
        
      end
    end

  end
end
