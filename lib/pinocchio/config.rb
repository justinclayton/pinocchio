# pinocchio/config
module Pinocchio
  class Config
    attr_accessor :vagrant_home
    attr_accessor :module_path
    attr_accessor :manifests_path
    attr_accessor :manifest_file
    attr_accessor :timeout_seconds
    attr_accessor :boxes
    attr_accessor :exposed_ports
    attr_accessor :destroy_vm_on_test_fail

    # isolating this allows us to avoid worrying about collision with newer (non-gem) vagrant installs.
    # it has the net side-effect of also isolating the box space
    VAGRANT_HOME            = File.join(ENV['HOME'], '.pinocchio', 'vagrant_home')
    # by default, vagrant looks in your spec/fixtures set up by puppetlabs_spec_helper
    MODULE_PATH             = File.join(Dir.pwd, 'spec', 'fixtures', 'modules')
    MANIFESTS_PATH          = File.join(Dir.pwd, 'spec', 'fixtures', 'manifests')
    MANIFEST_FILE           = 'pinocchio.pp'
    TIMEOUT_SECONDS         = 300
    DESTROY_VM_ON_TEST_FAIL = true

    def initialize
      yield self if block_given?

      @vagrant_home            = VAGRANT_HOME            if @vagrant_home.nil?
      @module_path             = MODULE_PATH             if @module_path.nil?
      @manifests_path          = MANIFESTS_PATH          if @manifests_path.nil?
      @manifest_file           = MANIFEST_FILE           if @manifest_file.nil?
      @timeout_seconds         = TIMEOUT_SECONDS         if @timeout_seconds.nil?
      @boxes                   = import_boxes            if @boxes.nil?
      @destroy_vm_on_test_fail = DESTROY_VM_ON_TEST_FAIL if @destroy_vm_on_test_fail.nil?

    end

    private

    def import_boxes
      boxes_yaml = File.join(File.expand_path '../../../boxes.yaml', __FILE__)
      return YAML.load_file(boxes_yaml)['boxes']
    end
  end
end