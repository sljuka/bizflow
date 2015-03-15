require "sqlite3"
require 'sequel'

module Bizflow
  class BuildCommand

    def self.run(config, args = [])

      puts "Building processes..."

      require 'bizflow/lib/semantic_builder'

      source_path = args[0] || config[:source_path]
      raise "dsl source path not specified" if source_path.nil?
      source_path = "#{Dir.pwd}/#{source_path}"
      domain_repo = Bizflow::Lib::SemanticBuilder.new(source_path).build

      raise "bizflow database path not specified" if config[:db_path].nil?
      db_path = "#{Dir.pwd}/#{config[:db_path]}"
      db = Sequel.sqlite(db_path)

      Dir["#{File.dirname(__FILE__)}/../model/*.rb"].each { |path| require_relative path }

      require 'bizflow/lib/blueprint_builder'

      Bizflow::Lib::BlueprintBuilder.new.build(domain_repo)

      puts "Processes built"

    end

  end
end