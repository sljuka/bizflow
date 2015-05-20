require "bizflow/command/build_command"
require "bizflow/command/help_command"
require "bizflow/command/clean_command"
require "bizflow/command/install_command"
require "bizflow/command/setup_command"
require "bizflow/command/migrate_command"

module Bizflow
  class CommandHelper

    CommandHash = {
      :help => Bizflow::HelpCommand,
      :build => Bizflow::BuildCommand,
      :clean => Bizflow::CleanCommand,
      :install => Bizflow::InstallComand,
      :setup => Bizflow::SetupCommand,
      :migrate => Bizflow::MigrateCommand
    }

  end
end
