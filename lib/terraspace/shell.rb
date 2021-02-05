require 'open3'

module Terraspace
  class Shell
    include Util::Logging

    def initialize(mod, command, options={})
      @mod, @command, @options = mod, command, options
    end

    # requires @mod to be set
    # quiet useful for RemoteState::Fetcher
    def run
      msg = "=> #{@command}"
      @options[:quiet] ? logger.debug(msg) : logger.info(msg)
      return if ENV['TS_TEST']
      shell
    end

    def shell
      env = @options[:env] || {}
      env.stringify_keys!
      if @options[:shell] == "system" # terraspace console
        system(env, @command, chdir: @mod.cache_dir)
      else
        popen3(env)
      end
    end

    def popen3(env)
      Open3.popen3(env, @command, chdir: @mod.cache_dir) do |stdin, stdout, stderr, wait_thread|
        while out = stdout.gets
          # so terraform output goes stdout
          if logger.respond_to?(:stdout) && !@options[:log_to_stderr]
            logger.stdout(out)
          else
            logger.info(out)
          end
        end

        while err = stderr.gets
          @error ||= Error.new
          @error.lines << err # aggregate all error lines
          unless @error.known?
            # Sometimes may print a "\e[31m\n" which like during dependencies fetcher init
            # suppress it so dont get a bunch of annoying "newlines"
            next if err == "\e[31m\n" && @options[:suppress_error_color]
            logger.error(err)
          end
        end

        status = wait_thread.value.exitstatus
        exit_status(status)
      end
    end

    def exit_status(status)
      return if status == 0

      exit_on_fail = @options[:exit_on_fail].nil? ? true : @options[:exit_on_fail]
      if @error && @error.known?
        raise @error.instance
      elsif exit_on_fail
        logger.error "Error running command: #{@command}".color(:red)
        exit status
      end
    end
  end
end
