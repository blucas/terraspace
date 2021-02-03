class Terraspace::Cloud::AbstractBase
  module Validations
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
