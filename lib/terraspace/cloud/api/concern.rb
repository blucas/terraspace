class Terraspace::Cloud::Api
  module Concern
    def api
      Terraspace::Cloud::Api.new(@options) # @options are CLI options
    end
  end
end
