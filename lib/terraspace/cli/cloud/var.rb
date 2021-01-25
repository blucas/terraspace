class Terraspace::CLI::Cloud
  class Var < Terraspace::Command
    Help = Terraspace::CLI::Help
    Var = Terraspace::Cloud::Var

    desc "list", "List variables."
    long_desc Help.text("cloud:var:list")
    option :format, desc: "Output formats: #{CliFormat.formats.join(', ')}"
    def list
      Var.new(options).list
    end

    desc "set VAR", "Set variable."
    long_desc Help.text("cloud:var:set")
    def set
      Var.new(options.merge(var: var)).set
    end

    desc "get VAR", "Get variable."
    long_desc Help.text("cloud:var:get")
    def get
      Var.new(options.merge(var: var)).get
    end

    desc "rm VAR", "Remove variable."
    long_desc Help.text("cloud:var:rm")
    def rm
      Var.new(options.merge(var: var)).rm
    end
  end
end
