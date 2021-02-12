module Terraspace::Cloud
  class Cost < AbstractBase
    def run
      result = api.create_cost_report(plan_id: @options[:plan])
      puts "create_cost_report result #{result}"
    end
  end
end
