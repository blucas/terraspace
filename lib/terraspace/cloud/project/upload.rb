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

      puts "upload complete"

      # s3_resource = Aws::S3::Resource.new(region: region)
      # object = s3_resource.bucket(bucket).object(object_key)
      # object

    #   Net::HTTP.start(url.host) do |http|
    #     http.send_request(
    #       'PUT',
    #       url.request_uri,
    #       object_content,
    #       'content-type' => ''
    #     )
    #   end
    #   content = object.get.body
    #   puts "The presigned URL for the object '#{object_key}' in the bucket '#{bucket_name}' is:\n\n"
    #   puts url
    #   puts "\nUsing this presigned URL to get the content that " \
    #     "was just uploaded to this object, the object\'s content is:\n\n"
    #   puts content.read
    #   return true
    # rescue StandardError => e
    #   puts "Error uploading to presigned URL: #{e.message}"
    #   return false
    end
  end
end
