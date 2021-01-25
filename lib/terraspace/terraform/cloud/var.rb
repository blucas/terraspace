module Terraspace::Terraform::Cloud
  class Var
    def initialize(options={})
      @options = options
    end

    def list
      api.list_variables
    end
  end
end
