module Terraspace::Cloud::Project
  class Upload < Base
    attr_reader :bucket
    def run
      uri = URI.parse(@options[:url])
      object_key = uri.path[1..-1] # remove leading /
      object_content = "test content"

      # bucket, _, region, _ = uri.host.split('.')
      # puts "bucket #{bucket}"
      # puts "region #{region}"
      # puts "object_key #{object_key}"

      resp = Net::HTTP.start(uri.host) do |http|
        http.send_request(
          'PUT',
          uri.request_uri,
          object_content,
          'content-type' => ''
        )
      end
      unless resp.code =~ /^20/
        puts "ERROR: Uploading code"
        exit 1
      end
    end
  end
end
