class Terraspace::CLI
  class Cloud < Terraspace::Command
    desc "var SUBCOMMAND", "var subcommands"
    long_desc Help.text(:var)
    subcommand "var", Var
  end
end
