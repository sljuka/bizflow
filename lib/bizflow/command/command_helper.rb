require "bizflow/command/build_command"
require "bizflow/command/help_command"
require "bizflow/command/clean_command"

module Bizflow
  class CommandHelper

    CommandHash = {
      :help => Bizflow::HelpCommand,
      :build => Bizflow::BuildCommand,
      :clean => Bizflow::CleanCommand
    }

  end
end
