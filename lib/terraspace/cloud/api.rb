module Terraspace::Cloud
  class Api
    include Core
    include Terraspace::Cloud::AwsServices

    def endpoint
      ENV['TERRASPACE_API'] || 'https://api.terraspace.cloud/api/v1'
    end

    def list_vars(options={})
      params = translate_keys(options)
      query_string = URI.encode_www_form(params)
      get("vars?#{query_string}")
    end

    def translate_keys(options)
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
