module Terraspace
  class App
    include Singleton
    include DslEvaluator

    attr_reader :config
    def initialize
      @config = defaults
    end

    def defaults
      ts_logger = Logger.new(ENV['TS_LOG_PATH'] || $stderr)

      config = ActiveSupport::OrderedOptions.new
      config.all = ActiveSupport::OrderedOptions.new
      config.all.concurrency = 5
      config.all.exit_on_fail = ActiveSupport::OrderedOptions.new
      config.all.exit_on_fail.down = true
      config.all.exit_on_fail.up = true
      config.all.ignore_stacks = []
      config.allow = ActiveSupport::OrderedOptions.new
      config.allow.envs = nil
      config.allow.regions = nil
      config.auto_create_backend = true
      config.build = ActiveSupport::OrderedOptions.new
      config.build.cache_dir = ":CACHE_ROOT/:REGION/:ENV/:BUILD_DIR"
      config.build.cache_root = nil # defaults to /full/path/to/.terraspace-cache
      config.build.clean_cache = nil # defaults to /full/path/to/.terraspace-cache
      config.bundle = ActiveSupport::OrderedOptions.new
      config.bundle.logger = ts_logger
      config.cloud = ActiveSupport::OrderedOptions.new
      config.cloud.project = "main"
      config.cloud.org = nil # required for Terraspace cloud
      config.hooks = Hooks.new
      config.init = ActiveSupport::OrderedOptions.new
      config.init.mode = "auto" # auto, never, always
      config.log = ActiveSupport::OrderedOptions.new
      config.log.root = Terraspace.log_root
      config.logger = ts_logger
      config.logger.formatter = Logger::Formatter.new
      config.logger.level = ENV['TS_LOG_LEVEL'] || :info
      config.summary = ActiveSupport::OrderedOptions.new
      config.summary.prune = false
      config.terraform = ActiveSupport::OrderedOptions.new
      config.terraform.plugin_cache = ActiveSupport::OrderedOptions.new
      config.terraform.plugin_cache.dir = ENV['TF_PLUGIN_CACHE_DIR'] || "#{Terraspace.tmp_root}/plugin_cache"
      config.terraform.plugin_cache.enabled = true
      config.terraform.plugin_cache.purge_on_error = true
      config.test_framework = "rspec"
      config.tfc = ActiveSupport::OrderedOptions.new
      config.tfc.auto_sync = true
      config.tfc.hostname = nil
      config.tfc.vars = ActiveSupport::OrderedOptions.new
      config.tfc.vars.overwrite = true
      config.tfc.vars.overwrite_sensitive = true
      config.tfc.vars.show_message = "create"
      config.tfc.working_dir_prefix = nil
      config.tfc.workspace = ActiveSupport::OrderedOptions.new
      config.tfc.workspace.attrs = ActiveSupport::OrderedOptions.new
      config
    end

    def configure
      yield(@config)
    end

    def load_project_config
      evaluate_file("#{Terraspace.root}/config/app.rb")
      path = "#{Terraspace.root}/config/env/#{Terraspace.env}.rb"
      evaluate_file(path)
    end
  end
end
