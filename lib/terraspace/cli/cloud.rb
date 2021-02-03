class Terraspace::CLI
  class Cloud < Terraspace::Command
    desc "var SUBCOMMAND", "var subcommands"
    long_desc Help.text(:var)
    subcommand "var", Var

    desc "project SUBCOMMAND", "project subcommands"
    long_desc Help.text(:project)
    subcommand "project", Project
  end
end
