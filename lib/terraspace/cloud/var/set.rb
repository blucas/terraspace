module Terraspace::Cloud::Var
  class Set < Base
    def run
      return unless valid?

      $stderr.puts "Setting #{@options[:level]} level variable for #{@org}/#{@project}:"
      result = api.set_var(@options)

      if errors?(result)
        error_message(result)
      else
        show_result(result)
      end
    end

    def show_result(result)
      record = load_record(result) # can use option for name, but using record so we know that we saved the right one
      $stderr.puts "Variable #{record['name']} has been set"
      view = case @options[:level]
      when "org", "project"
        "terraspace cloud var list --level #{@options[:level]}"
      when "stack", "deployment"
        "terraspace cloud var list --level #{@options[:level]} --stack=#{@stack}"
      end
      $stderr.puts <<~EOL
        To view variable:

            #{view}

      EOL
    end
  end
end
