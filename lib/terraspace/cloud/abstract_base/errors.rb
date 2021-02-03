class Terraspace::Cloud::AbstractBase
  module Errors
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
      $stderr.puts "Your current settings. org: #{@org} project: #{@project}"
    end
  end
end
