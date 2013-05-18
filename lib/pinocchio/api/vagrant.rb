# pinocchio/api/vagrant
module Pinocchio
  def self.assign_test_manifest test_manifest
    source_dir = test_manifest
    dest_dir   = File.join(Pinocchio.manifests_path, Pinocchio.manifest_file)
    FileUtils.copy_file(source_dir, dest_dir)
  end

  def self.vagrant_init
    @vagrant = Vagrant::Prison.new

    @vagrant.configure do |config|
      config.vm.host_name = 'puppet.pinocchio.test'
      ## XXX: parameterize this (in cucumber given?)
      Pinocchio.exposed_ports.each do |port|
        guest_port = port.to_i
        host_port  = guest_port + 1000
        config.vm.forward_port guest_port, host_port
      end
      Pinocchio.boxes.each do |box_name|
        config.vm.define box_name.to_sym, :primary => true do |c|
          c.vm.box = box_name
          ## XXX: box hash or class to manage urls?
          c.vm.box_url = File.expand_path("~/vagrant/boxes/#{box_name}.box")
          c.vm.provision :puppet do |puppet|
            puppet.module_path    = 'modules'
            puppet.manifests_path = Pinocchio.manifests_path
            puppet.manifest_file  = Pinocchio.manifest_file
          end
        end
      end
    end
    return @vagrant
  end

  def self.vagrant_provision box_name
    Vagrant::Command::Provision.new([box_name], @vagrant.construct(:ui_class => Vagrant::UI::Basic)).execute
  end

  def self.vagrant_up box_name
    # even though we dont care yet, vagrant still needs puppet.manifest_file to exist on vagrant up
    FileUtils.touch File.join(Pinocchio.manifests_path, Pinocchio.manifest_file)
    FileUtils.mkdir_p Pinocchio.vagrant_prison_module_dir
    Vagrant::Command::Up.new([box_name, '--no-provision'], @vagrant.construct(:ui_class => Vagrant::UI::Basic)).execute
    # p @vagrant.construct.config.cwd
    Pinocchio.sync_module_fixtures
  end

  def self.vagrant_prison_module_dir
    vagrant_prison_basedir = @vagrant.construct.cwd.to_s
    return File.join(vagrant_prison_basedir, 'modules')
  end

  def self.sync_module_fixtures
    ## since spec/fixtures/modules is full of symlinks, we can't just use
    ## it as vagrant's modulepath for puppet because they'd all be broken.
    ## instead, we copy what we need into the vagrant prison's dir.
    source_files = Dir.glob(File.join(Pinocchio.module_path, '*'))
    ## XXX: assumes constant of relative path 'modules' in vagrant config; support others

    # module_path = @vagrant.construct.config.global.vm.provisioners.first.config.module_path.to_s
    p dest_dir = vagrant_prison_module_dir
    FileUtils.cp_r(source_files, dest_dir)
  end
end