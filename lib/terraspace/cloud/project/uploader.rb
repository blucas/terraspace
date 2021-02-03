module Terraspace::Cloud::Project
  class Uploader < Base
    attr_reader :record

    def upload(zip_path)
      @record = create_record
      upload_project(@record['url'], zip_path)
    end

    def create_record
      record = api.create_upload
      if errors?(record)
        error_message(record)
        exit 1 # TODO: consider: raise exception can rescue higher up
      else
        record
      end
    end

    def upload_project(url, path)
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
