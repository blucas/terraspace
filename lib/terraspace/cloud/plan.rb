module Terraspace::Cloud
  class Plan < AbstractBase
    def run
      zip_path = package_project
      url = get_presigned_url
      upload(url, zip_path)
    end

    def package_project
      package = Project::Package.new(@options)
      package.build
      package.path
    end

    def get_presigned_url
      url = Project::Url.new(@options)
      url.presigned_url
    end

    def upload(url, zip_path)
      upload = Project::Upload.new(@options)
      upload.upload(url, zip_path)
    end
  end
end
