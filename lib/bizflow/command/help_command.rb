module Bizflow
  class HelpCommand

    def self.run(config, args)
      puts "run one of these commands like this:"
      puts "bizflow COMMAND_NAME [ARGS]"
      puts "commands:\n#{Bizflow::CommandHelper::CommandHash.keys.join("\n")}"
    end

  end
end
