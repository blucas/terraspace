class Terraspace::Cloud::Api
  class Base
    include Concern
    include Terraspace::Cloud::AwsServices

    def initialize(options={})
      @options = options
    end
  end
end
