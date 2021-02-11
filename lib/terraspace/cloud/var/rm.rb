module Terraspace::Cloud::Var
  class Rm < Base
    def run
      return unless valid?

      $stderr.puts "Removing #{@options[:type]} level variables for #{@options[:org]}/#{@options[:project]}:"
      result = api.rm_var(@options)
      if errors?(result)
        error_message(result)
      else
        show_result(result)
      end
    end

    def show_result(result)
      $stderr.puts "Variable #{@options[:name]} has been removed"
    end
  end
end
