module Terraspace::Cloud::Var
  class Base < Terraspace::Cloud::AbstractBase
    def valid?
      if @options[:level] == "deployment" && !@options[:stack]
        puts "ERROR: When using --type deployment, please specify the env. IE: --stack NAME"
        return false
      elsif @options[:level] == "stack" && !@options[:stack]
        puts "ERROR: When using --type stack, please specify the env. IE: --stack NAME"
        return false
      elsif @options[:level] == "env" && @options[:stack] # in case user accidentally specifies stack. env is inferred
        puts "ERROR: When using --type env, please specify the env. IE: --env NAME."
        puts "Note: you can also not specify it and the current TS_ENV is used."
        return false
      end
      true
    end
  end
end
