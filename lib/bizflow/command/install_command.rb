require 'bizflow/config_generator'

module Bizflow
  class InstallComand

    def self.run(config, args)
      cg = Bizflow::ConfigGenerator.new()
      cg.generate
      puts "bizflow_config built in root path"
    end

  end
end