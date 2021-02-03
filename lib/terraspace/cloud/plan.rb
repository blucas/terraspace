module Terraspace::Cloud
  class Plan < AbstractBase
    def run
      package_project
    end

    def package_project
      package = Project::Package.new(@options)
      package.build
    end
  end
end
