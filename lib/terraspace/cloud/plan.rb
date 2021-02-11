module Terraspace::Cloud
  class Plan < AbstractBase
    def run
      zip_path = package_project
      uploader = Project::Uploader.new(@options)
      uploader.upload(zip_path)
      start_plan(uploader.record)
    end

    def package_project
      package = Project::Package.new(@options)
      package.build
      package.path
    end

    def start_plan(upload)
      result = api.start_plan(upload_id: upload['uid'])
      puts "start_plan result #{result}"
    end
  end
end
