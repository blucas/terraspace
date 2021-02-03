module Terraspace::Cloud::Project
  class Upload < Base
    def upload(url, path)
      uri = URI.parse(url)
      object_content = IO.read(path)
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
        exit 1 # TODO: consider raising error
      end
    end
  end
end
