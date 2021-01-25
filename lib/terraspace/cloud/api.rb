module Terraspace::Cloud
  class Api
    include Core
    include Terraspace::Cloud::AwsServices

    def endpoint
      ENV['TERRASPACE_API'] || 'https://api.terraspace.cloud/api/v1'
    end

    def list_vars(params={})
      query_string = URI.encode_www_form(params)
      get("vars?#{query_string}")
    end
  end
end
