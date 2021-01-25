module Terraspace::Cloud
  class Var
    include Terraspace::Cloud::Api::Concern
    def initialize(options={})
      @options = options
    end

    def list
      vars = api.list_vars
      return unless vars # nil if not authorized
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = %w[Name Value Kind Sensitive]
      vars.each do |var|
        row = [var['name'], var['value'], var['kind'], !!var['sensitive']]
        presenter.rows << row
      end
      presenter.show
    end
  end
end
