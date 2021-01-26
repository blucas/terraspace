module Terraspace::Cloud::Var
  class Set < Base
    def run
      return unless valid?

      $stderr.puts "Setting #{@options[:type]} level variables for #{@options[:org]}/#{@options[:project]}:"
      result = api.set_var(@options)
      return unless result # 500 error

      if errors?(result)
        error_message(result)
      else
        show_result(result)
      end
    end

    def show_result(result)
      $stderr.puts "Variable #{@options[:name]} has been set"
      view = case @options[:type]
      when "org", "project"
        "terraspace cloud var list --type #{@options[:type]}"
      when "env"
        "terraspace cloud var list --type #{@options[:type]} --env=#{@options[:env]}"
      when "stack", "stack_env"
        "terraspace cloud var list --type #{@options[:type]} --stack=#{@options[:stack]}"
      end
      $stderr.puts <<~EOL
        To view variable:

            #{view}

      EOL
    end
  end
end
