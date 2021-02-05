module Terraspace::Cloud
  class Apply < AbstractBase
    def run
      result = api.apply_plan(plan_id: @options[:plan])
      puts "start_deploy result #{result}"
    end
  end
end
