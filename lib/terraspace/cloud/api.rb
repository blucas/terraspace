module Terraspace::Cloud
  class Api
    include AwsServices
    include Context
    include HttpMethods

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

    def create_upload(options={})
      post("#{project_path}/uploads")
    end

    def list_vars(options={})
      query_string = URI.encode_www_form(params)
      get("vars?#{query_string}")
    end

    def set_var(options={})
      data = translate_keys(options)
      put("vars/#{options[:name]}", data)
    end

    def rm_var(options={})
      data = translate_keys(options)
      delete("vars/#{options[:name]}", data)
    end

  private
    def translate_keys(options={})
      options.transform_keys do |key|
        map = {
          org: :org_id,
          project: :project_id,
          env: :env_id,
          stack: :stack_id,
        }
        map[key.to_sym] || key
      end
    end
  end
end
