module Terraspace::Cloud
  class Policy < AbstractBase
    def run
      result = api.create_policy_check(plan_id: @options[:plan])
      puts "create_policy_check result #{result}"
    end
  end
end
