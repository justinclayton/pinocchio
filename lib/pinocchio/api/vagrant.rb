# pinocchio/api/vagrant
module Pinocchio
  def self.assign_test_manifest test_manifest
    p source = test_manifest
    p dest   = File.join(Pinocchio.manifests_path, Pinocchio.manifest_file)
    FileUtils.copy_file(source, dest)
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
            puppet.module_path    = Pinocchio.module_path
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
    Pinocchio.manifests_path
    Pinocchio.manifest_file
    FileUtils.touch File.join(Pinocchio.manifests_path, Pinocchio.manifest_file)
    Vagrant::Command::Up.new([box_name, '--no-provision'], @vagrant.construct(:ui_class => Vagrant::UI::Basic)).execute
  end
end