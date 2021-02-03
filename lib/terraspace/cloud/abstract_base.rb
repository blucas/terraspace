module Terraspace::Cloud
  class AbstractBase
    include Terraspace::Cloud::Api::Concern

    def initialize(options={})
      @options = options
      cloud = Terraspace.config.cloud
      @options[:org] = cloud.org
      @options[:project] = cloud.project
      @options[:env] ||= Terraspace.env
    end
  end
end
