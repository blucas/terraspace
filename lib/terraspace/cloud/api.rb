module Terraspace::Cloud
  class Api
    include AwsServices
    include Context
    include HttpMethods
    # Apis
    include Vars

    def initialize(options)
      @options = options # @options are CLI options
      setup_context(options)
    end

    def endpoint
      ENV['TERRASPACE_API'] || 'https://api.terraspace.cloud/api/v1'
    end

    def project_path
      "orgs/#{@org}/projects/#{@project}"
    end

    def deployment_path
      "#{project_path}/stacks/#{@stack}/envs/#{@env}"
    end

    def create_upload
      post("#{deployment_path}/uploads")
    end

    def start_plan(record)
      post("#{deployment_path}/plans", record)
    end

    def apply_plan(record)
      post("#{deployment_path}/applies", record)
    end

    def create_cost_report(record)
      post("#{deployment_path}/costs", record)
    end
  end
end
