module Terraspace::Cloud
  class AbstractBase
    include Terraspace::Cloud::Api::Concern
    include Terraspace::Util

    def initialize(options={})
      @options = options
      cloud = Terraspace.config.cloud
      @org = @options[:org] = cloud.org
      @project = @options[:project] = cloud.project
      @env = @options[:env] ||= Terraspace.env
      @stack = @options[:stack]
    end
  end
end
