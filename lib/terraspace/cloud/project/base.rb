module Terraspace::Cloud::Project
  class Base < Terraspace::Cloud::AbstractBase
    # final zip dest
    def project_zip
      "#{project_folder}.zip"
    end

    def project_folder
      "#{builds_cache}/#{@org}/#{@project}"
    end

    def builds_cache
      "#{ENV['HOME']}/.terraspace/cache/builds"
    end
  end
end
