module Terraspace::Cloud::Var
  class List < Base
    def run
      return unless valid?

      $stderr.puts "Showing #{@options[:level]} level variables for #{@org}/#{@project}:"
      result = api.list_vars(@options)
      if errors?(result)
        error_message(result)
      else
        show_variables(result)
      end
    end

    def show_variables(result)
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = %w[Name Value Kind Sensitive]
      vars = load_records(result)
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
