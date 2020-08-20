class Terraspace::Terraform::Cloud
  class Workspace < Terraspace::CLI::Base
    extend Memoist
    include Terraspace::Util::Logging
    include Terraspace::Terraform::Api::Client

    # List will not have @mod set.
    def list
      @mod = Terraspace::CLI::Build::Placeholder.new(@options).build
      unless remote && remote['organization']
        logger.info "ERROR: There was no organization found. Are you sure you configured backend.tf with it?".color(:red)
        exit 1
      end

      org = remote['organization']
      payload = http.get("/organizations/#{org}/workspaces") # list using api client directly
      names = payload['data'].map { |i| i['attributes']['name'] }.sort
      logger.info "Workspaces for #{org}:"
      logger.info names.join("\n")
    end

    def setup
      build
      unless backend.dig('remote','workspaces') # in case called by terraspace down demo -y --destroy-workspace with a non-remote backend
        logger.info "ERROR: Workspace not configured in backend.tf"
        exit 1
      end
      init
    end

    def init
      Terraspace::CLI::Init.new(@options.merge(calling_command: "cloud-setup")).run
    end

    def destroy
      build
      return unless backend.dig('remote','workspaces') # in case called by terraspace down demo -y --destroy-workspace with a non-remote backend
      api = Terraspace::Terraform::Api.new(@mod, remote)
      workspace = api.workspace(exit_on_fail: false)
      unless workspace
        logger.info "Workspace #{workspace_name} not found for #{@mod.type}: #{@mod.name}"
        exit 0
      end
      sure?
      logger.info "Destroying workspace #{workspace_name}"
      api.destroy_workspace
    end

    def build
      Terraspace::Builder.new(@options).run
    end

    def workspace_name
      remote['workspaces']['name']
    end

    def remote
      backend["remote"]
    end

    def backend
      Terraspace::Compiler::Backend::Parser.new(@mod).result
    end
    memoize :backend

    def sure?
      message = <<~EOL.chop + " " # chop to remove newline
        You are about to delete the workspace: #{workspace_name}
        All variables, settings, run history, and state history will be removed.
        This cannot be undone.

        This will NOT remove any infrastructure managed by this workspace.
        If needed, destroy the infrastructure prior to deleting the workspace with:

            terraspace down #{@mod.name}

        This will delete the workspace: #{workspace_name}.
        Are you sure? (y/N)
      EOL

      if @options[:yes]
        sure = 'y'
      else
        print message
        sure = $stdin.gets
      end

      unless sure =~ /^y/
        puts "Whew! Exiting."
        exit 0
      end
    end
  end
end

