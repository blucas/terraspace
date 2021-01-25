module Terraspace::Cloud
  class Api
    include Core
    include Terraspace::Cloud::AwsServices

    def endpoint
      ENV['TERRASPACE_API'] || 'https://api.terraspace.cloud/api/v1'
    end

    def list_vars
      get('vars')
    end
  end
end
