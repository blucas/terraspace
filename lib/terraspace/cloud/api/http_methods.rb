class Terraspace::Cloud::Api
  module HttpMethods
    extend Memoist
    include Terraspace::Util

    # Always translate raw json response to ruby Hash
    def request(klass, path, data={})
      url = url(path)
      req = build_request(klass, url, data)
      resp = http.request(req) # send request
      load_json(url, resp)
    end

    def build_request(klass, url, data={})
      req = klass.new(url) # url includes query string and uri.path does not, must used url
      set_headers!(req)
      if [Net::HTTP::Delete, Net::HTTP::Patch, Net::HTTP::Post, Net::HTTP::Put].include?(klass)
        text = JSON.dump(data)
        # puts "JSON.dump data:".color(:yellow)
        # pp data
        req.body = text
        req.content_length = text.bytesize
      end

      logger.info "API klass: #{klass}"
      logger.info "API url: #{url}"
      logger.info "API data: #{data}"

      req
    end

    def set_headers!(req)
      req['Authorization'] = token if token
      req['Content-Type'] = 'application/json'
    end

    def token
      ENV['TERRASPACE_TOKEN'] # || load from yaml
    end

    def load_json(url, res)
      uri = URI(url)

      # puts "res.code #{res.code}"
      # puts "res.body #{res.body}" # {"errors":[{"message":"403 Forbidden"}]}

      if parseable?(res.code)
        JSON.load(res.body)
      else
        puts "Error: Non-successful http response status code: #{res.code}"
        puts "Error: Non-successful http response body: #{res.body}"
        puts "headers: #{res.each_header.to_h.inspect}"
        puts "Terraspace Cloud API #{url}"
        raise "Terraspace Cloud API called failed: #{uri.host}"
      end
    end

    # Note: 422 is Unprocessable Entity. This means an invalid data payload was sent.
    # We want that to error and raise
    def parseable?(http_code)
      http_code =~ /^20/ || http_code =~ /^40/
    end

    def http
      uri = URI(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = http.read_timeout = 30
      http.use_ssl = true if uri.scheme == 'https'
      http
    end
    memoize :http

    # API does not include the /. IE: https://app.terraform.io/api/v2
    def url(path)
      "#{endpoint}/#{path}"
    end

    def get(path)
      request(Net::HTTP::Get, path)
    end

    def post(path, data={})
      request(Net::HTTP::Post, path, data)
    end

    def put(path, data={})
      request(Net::HTTP::Put, path, data)
    end

    def patch(path, data={})
      request(Net::HTTP::Patch, path, data)
    end

    def delete(path, data={})
      request(Net::HTTP::Delete, path, data)
    end
  end
end
