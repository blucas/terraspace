require "aws-sdk-s3"

module Terraspace::Cloud
  module AwsServices
    extend Memoist

    def s3
      Aws::S3::Client.new
    end
    memoize :s3
  end
end
