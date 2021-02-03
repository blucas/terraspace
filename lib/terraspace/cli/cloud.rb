class Terraspace::CLI
  class Cloud < Terraspace::Command
    desc "var SUBCOMMAND", "var subcommands"
    long_desc Help.text(:var)
    subcommand "var", Var

    desc "project SUBCOMMAND", "project subcommands"
    long_desc Help.text(:project)
    subcommand "project", Project

    desc "plan", "Runs plan on the cloud"
    long_desc Help.text("cloud/plan")
    def plan(stack)
      Terraspace::Cloud::Plan.new(options.merge(stack: stack)).run
    end
  end
end
