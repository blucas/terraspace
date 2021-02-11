class Terraspace::Cloud::Api
  module Vars
    def list_vars(options={})
      get(var_path)
    end

    def set_var(options={})
      put(var_path(options[:name]), options)
    end

    def rm_var(options={})
      delete(var_path(options[:name]), options)
    end

  private
    def var_path(name=nil)
      path = case @options[:level]
      when "deployment"
        "orgs/#{@org}/projects/#{@project}/stacks/#{@stack}/envs/#{@env}"
      when "stack"
        "orgs/#{@org}/projects/#{@project}/stacks/#{@stack}"
      when "project"
        "orgs/#{@org}/projects/#{@project}"
      when "org"
        "orgs/#{@org}"
      else
        raise "Invalid kind #{@options[:level]}"
      end
      ["#{path}/vars", name].compact.join('/')
    end
  end
end
