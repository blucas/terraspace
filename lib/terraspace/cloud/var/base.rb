module Terraspace::Cloud::Var
  class Base < Terraspace::Cloud::AbstractBase
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
      if @options[:type] == "stack_env" && !@options[:stack]
        puts "ERROR: When using --type stack_env, please specify the env. IE: --stack NAME"
        return false
      elsif @options[:type] == "stack" && !@options[:stack]
        puts "ERROR: When using --type stack, please specify the env. IE: --stack NAME"
        return false
      elsif @options[:type] == "env" && @options[:stack] # in case user accidentally specifies stack. env is inferred
        puts "ERROR: When using --type env, please specify the env. IE: --env NAME."
        puts "Note: you can also not specify it and the current TS_ENV is used."
        return false
      end
      true
    end
  end
end
