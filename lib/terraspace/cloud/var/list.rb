module Terraspace::Cloud::Var
  class List < Base
    def run
      return unless valid?

      $stderr.puts "Showing #{@options[:type]}-level variables for #{@options[:org]}/#{@options[:project]}:"
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

      if presenter.rows.empty?
        $stderr.puts "No variables were found"
      else
        presenter.show
      end
    end
  end
end
