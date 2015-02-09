require 'bizflow/fakes/process'
require 'bizflow/fakes/action'
require 'bizflow/fakes/head'

module Bizflow

  class TestRepo

    def initialize(blueprints)
      @blueprints = blueprints
    end

    def create_process(name)
      process_blueprints = @blueprints.select { |bp| bp.name == name }
      raise "no process with name '#{name}'" if process_blueprints.empty?
      pbp = process_blueprints.first

      p = Bizflow::Fakes::Process.new(pbp.name, pbp.description)
      
      pbp.action_blueprints.each do |bp|
        b = Bizflow::Fakes::Action.new(p, bp, bp.name, bp.type)
        p.actions << b
        p.start_action = b if pbp.start_action == bp.name
      end

      h = Bizflow::Fakes::Head.new(p)

      p
    end

  end

end
