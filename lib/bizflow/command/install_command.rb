require 'bizflow/config_generator'
require 'fileutils'

module Bizflow
  class InstallComand

    def self.run(config, args)
      cg = Bizflow::ConfigGenerator.new()
      cg.generate
      puts "bizflow_config created in root path"

      FileUtils::mkdir_p "#{Dir.pwd}/bizflow_processes"
    end

  end
end