class Terraspace::CLI
  class Cloud < Terraspace::Command
    desc "var SUBCOMMAND", "var subcommands"
    long_desc Help.text(:var)
    subcommand "var", Var

    desc "cost", "Runs cost on the cloud"
    long_desc Help.text("cloud/cost")
    option :plan, required: true, desc: "plan id"
    def cost(stack)
      Terraspace::Cloud::Cost.new(options.merge(stack: stack)).run
    end

    desc "apply", "Runs apply on the cloud"
    long_desc Help.text("cloud/apply")
    option :plan, required: true, desc: "plan id"
    def apply(stack)
      Terraspace::Cloud::Apply.new(options.merge(stack: stack)).run
    end

    desc "plan", "Runs plan on the cloud"
    long_desc Help.text("cloud/plan")
    def plan(stack)
      Terraspace::Cloud::Plan.new(options.merge(stack: stack)).run
    end
  end
end
