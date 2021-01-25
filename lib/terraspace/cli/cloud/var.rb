class Terraspace::CLI::Cloud
  class Var < Terraspace::Command
    Help = Terraspace::CLI::Help
    Var = Terraspace::Cloud::Var

    class_option :env, desc: "Env name. Overrides TS_ENV"
    class_option :kind, aliases: %w[k], default: "terraform", desc: "Kind: environment or terraform"
    class_option :sensitive, boolean: false, desc: "Whether or not the variable sensitive"
    class_option :stack, desc: "Stack name. Only use when type is stack"
    class_option :type, aliases: %w[t], default: "project", desc: "Variable type: stack_env, stack, env, project, or org"

    desc "list", "List variables."
    long_desc Help.text("cloud:var:list")
    option :format, desc: "Output formats: #{CliFormat.formats.join(', ')}"
    def list
      Var::List.new(options).run
    end

    desc "set VAR", "Set variable."
    long_desc Help.text("cloud:var:set")
    def set(name, value)
      Var::Set.new(options.merge(name: name, value: value)).run
    end

    desc "rm VAR", "Remove variable."
    long_desc Help.text("cloud:var:rm")
    def rm(name)
      Var::Rm.new(options.merge(name: name)).run
    end
  end
end
