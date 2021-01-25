module Terraspace::Cloud
  class Var
    include Terraspace::Cloud::Api::Concern
    def initialize(options={})
      @options = options
      cloud = Terraspace.config.cloud
      @options[:org] = cloud.org
      @options[:project] = cloud.project
    end

    def list
      vars = api.list_vars(@options)
      return unless vars # 500 error

      if errors?(vars)
        error_message(vars)
      else
        show_variables(vars)
      end
    end

    def show_variables(vars)
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = %w[Name Value Kind Sensitive]
      vars.each do |var|
        row = [var['name'], var['value'], var['kind'], !!var['sensitive']]
        presenter.rows << row
      end

      $stderr.puts "Variables type: #{@options[:type]}"
      if presenter.rows.empty?
        $stderr.puts "No variables were found for #{@options[:org]}/#{@options[:project]}"
      else
        presenter.show
      end
    end

    def errors?(vars)
      vars.is_a?(Hash) && vars.key?("errors")
    end

    def error_message(vars)
      vars["errors"].each do |error|
        case error["message"]
        when /Forbidden/
          $stderr.puts "You are not authorized to see these variables. Double check your token and permissions."
        when /Not Found/
          $stderr.puts "The variable was not found. Double check the variable."
        end
      end
      $stderr.puts "Your current org #{@options[:org]} project #{@options[:project]}"
    end
  end
end
