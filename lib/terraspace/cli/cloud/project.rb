class Terraspace::CLI::Cloud
  class Project < Terraspace::Command
    Help = Terraspace::CLI::Help
    Project = Terraspace::Cloud::Project

    class_option :env, desc: "Env name. Overrides TS_ENV"
    class_option :stack, desc: "Stack name. Only use when type is stack"

    desc "upload", "upload variables."
    long_desc Help.text("cloud:project:upload")
    option :url, desc: "url"
    def upload
      Project::Upload.new(options).run
    end
  end
end
