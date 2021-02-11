module Terraspace::Terraform::Ihooks::Before
  class Plan < Terraspace::Terraform::Ihooks::Base
    def run
      out = @options[:out]
      return unless out
      out = @options[:out]
      name = out.sub("#{Terraspace.root}/",'')
      dest = "#{@mod.cache_dir}/#{name}"
      FileUtils.mkdir_p(File.dirname(dest))
    end
  end
end
