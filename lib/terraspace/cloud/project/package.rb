require 'zip_folder'

module Terraspace::Cloud::Project
  class Package < Base
    def build
      logger.debug "Building terraspace project package"
      copy
      tidy
      logger.debug "Copied terraspace project to #{pretty_path(project_folder)}"
      zip
      logger.debug "Built terraspace project package in #{project_zip}"
      project_zip # important to return path
    end

    def copy
      FileUtils.rm_rf(project_folder)
      FileUtils.mkdir_p(File.dirname(project_folder))
      FileUtils.cp_r(Dir.pwd, project_folder)
    end

    def tidy
      Tidy.new(@options).cleanup
    end

    def zip
      FileUtils.rm_f(project_zip)
      ZipFolder.zip(project_folder, project_zip)
    end
  end
end
