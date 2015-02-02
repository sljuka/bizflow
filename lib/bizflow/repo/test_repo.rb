require 'bizflow/fakes/process'
require 'bizflow/fakes/block'
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
      
      pbp.block_blueprints.each do |bp|
        b = Bizflow::Fakes::Block.new(p, bp, bp.name, bp.type)
        p.blocks << b
        p.start_block = b if pbp.start_block == bp.name
      end

      h = Bizflow::Fakes::Head.new(p)
      h.block = p.start_block

      p
    end

  end

end
