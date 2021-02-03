require 'zip'
require 'zip/filesystem'

module Terraspace::Cloud::Project
  class Package < Base
    def build
      logger.debug "Building terraspace project package"
      copy
      tidy
      logger.debug "Built terraspace project package in #{pretty_path(project_cache)}"
      zip(project_cache)
      logger.info "Built terraspace project package in #{pretty_path(path)}"
    end

    def path
      @archive_path
    end

    def copy
      FileUtils.rm_rf(project_cache)
      FileUtils.mkdir_p(File.dirname(project_cache))
      FileUtils.cp_r(Dir.pwd, project_cache)
    end

    def tidy
      %w[.git .terraspace-cache].each do |dir|
        FileUtils.rm_rf("#{project_cache}/#{dir}")
      end
    end

    # https://stackoverflow.com/questions/11509802/zipping-a-directory-in-rails
    def zip(path)
      path.sub!(%r[/$],'')
      @archive_path = File.join(path, File.basename(path)) + '.zip'
      FileUtils.rm(@archive_path, force: true)

      Zip::File.open(@archive_path, 'w') do |zipfile|
        Dir["#{path}/**/**"].reject{|f|f==@archive_path}.each do |file|
          zipfile.add(file.sub(path+'/',''),file)
        end
      end
    end

    def project_cache
      "#{builds_cache}/#{@org}/#{@project}"
    end

    def builds_cache
      "#{ENV['HOME']}/.terraspace/cache/builds"
    end
  end
end
