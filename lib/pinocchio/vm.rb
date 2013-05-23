# pinocchio/vm
require 'vagrant/prison'

module Pinocchio
  class VM
    attr_accessor :name
    attr_accessor :config
    attr_accessor :vagrant_env
    attr_reader   :vagrant_module_path

    def initialize(box_name, config)
      @config = config
      # check that box_name is a valid one
      if config.boxes.has_key? box_name
        @name = box_name
      else
        raise "#{box_name} is not a valid box name. Valid names are #{self.config.boxes.keys.to_s}"
      end
      ## this is what gets passed to vagrant, not where the actual modules are. don't change this.
      @vagrant_module_path = 'modules'

      puts "DESTROY VM ON TEST FAIL? SET TO #{@config.destroy_vm_on_test_fail}"

      @vagrant_env = Vagrant::Prison.new(nil, @config.destroy_vm_on_test_fail)

      @vagrant_env.configure do |vagrant|
        vagrant.vm.host_name = 'puppet.pinocchio.test'
        if @config.exposed_ports
          @config.exposed_ports.each do |port|
            guest_port = port.to_i
            host_port  = guest_port + 1000
            vagrant.vm.forward_port guest_port, host_port
          end
        end
        vagrant.vm.box     = @name
        vagrant.vm.box_url = @config.boxes[@name]
        ## host firewalls NOPE NOPE NOPE
        vagrant.vm.provision :shell, :inline => 'iptables -F'
        vagrant.vm.provision :puppet do |puppet|
          puppet.module_path    = @vagrant_module_path
          puppet.manifests_path = @config.manifests_path
          puppet.manifest_file  = @config.manifest_file
        end
      end
    end

    def up
      # even though we dont care yet, vagrant still needs puppet.manifest_file to exist on vagrant up
      FileUtils.touch File.join(@config.manifests_path, @config.manifest_file)
      FileUtils.mkdir_p vagrant_prison_module_dir
      Vagrant::Command::Up.new(['--no-provision'], @vagrant_env.construct(:ui_class => Vagrant::UI::Basic)).execute
      sync_module_fixtures
    end

    def apply_test(manifest)
      assign_test_manifest manifest
      provision
    end

    ## run `vagrant provision`, which will puppet apply the test manifest
    def provision
      ## TODO: limit to only run puppet provisioner, similar to the up flag `--provision-with puppet`
      Vagrant::Command::Provision.new([], @vagrant_env.construct(:ui_class => Vagrant::UI::Basic)).execute
    end

    private

    def vagrant_prison_module_dir
      ## TODO: assumes constant of relative path 'modules' in vagrant config; support others?
      vagrant_prison_basedir = @vagrant_env.construct.cwd.to_s
      return File.join(vagrant_prison_basedir, @vagrant_module_path)
    end

    def sync_module_fixtures
      ## since spec/fixtures/modules is full of symlinks, we can't just use
      ## it as vagrant's modulepath for puppet because they'd all be broken.
      ## instead, we copy what we need into the vagrant prison's dir.
      source_files = Dir.glob(File.join(@config.module_path, '*'))
      dest_dir = vagrant_prison_module_dir
      FileUtils.cp_r(source_files, dest_dir)
    end

    ## copy the test manifest to where the vagrant prison environment is looking for it
    def assign_test_manifest(manifest)
      source_dir = manifest
      dest_dir   = File.join(@config.manifests_path, @config.manifest_file)
      FileUtils.copy_file(source_dir, dest_dir)
    end

  end
end