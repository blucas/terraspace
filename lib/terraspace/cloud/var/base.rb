module Terraspace::Cloud::Var
  class Base
    include Terraspace::Cloud::Api::Concern

    def initialize(options={})
      @options = options
      cloud = Terraspace.config.cloud
      @options[:org] = cloud.org
      @options[:project] = cloud.project
      @options[:env] ||= Terraspace.env
    end

    def errors?(result)
      result.is_a?(Hash) && result.key?("errors")
    end

    def error_message(result)
      result["errors"].each do |error|
        case error
        when /Forbidden/
          $stderr.puts "ERROR: You are not authorized to perform this action. Double check your token and permissions."
        when /Not Found/
          $stderr.puts "ERROR: Variables not found. Double check command and options."
        else
          $stderr.puts "ERROR: #{error}"
        end
      end
      $stderr.puts "Your current settings: org #{@options[:org]} project #{@options[:project]}"
    end

    def valid?
      if @options[:type] == "stack" && !@options[:stack]
        puts "ERROR: When using --type stack, please specify the env. IE: --stack NAME"
        return false
      end
      true
    end
  end
end
