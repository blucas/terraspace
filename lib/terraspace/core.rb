module Terraspace
  module Core
    extend Memoist

    def env
      ENV['TS_ENV'] || "dev"
    end
    memoize :env

    @@root = nil
    def root
      @@root ||= ENV['TS_ROOT'] || Dir.pwd
    end

    # allow testing frameworks to switch roots
    def root=(v)
      @@root = v
    end

    def cache_root
      ENV['TS_CACHE_ROOT'] || config.build.cache_root || "#{root}/.terraspace-cache"
    end
    memoize :cache_root

    def tmp_root
      ENV['TS_TMP_ROOT'] || "/tmp/terraspace"
    end
    memoize :tmp_root

    def configure(&block)
      App.instance.configure(&block)
    end

    # Generally, use the Terraspace.config instead of App.instance.config since it guarantees the load_project_config call
    def config
      App.instance.load_project_config
      App.instance.config
    end
    memoize :config

    def logger
      config.logger
    end
    memoize :logger

    def check_project!
      return if File.exist?("#{Terraspace.root}/config/app.rb")
      logger.error "ERROR: It doesnt look like this is a terraspace project. Are you sure you are in a terraspace project?".color(:red)
      ENV['TS_TEST'] ? raise : exit(1)
    end
  end
end
