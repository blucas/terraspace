module Terraspace::Cloud
  class AbstractBase
    include Api::Concern
    include Context
    include Terraspace::Util
    include Errors
    include Validations

    def initialize(options={})
      @options = options
      setup_context(options)
    end
  end
end
