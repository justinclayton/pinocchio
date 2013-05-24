# pinocchio/config
module Pinocchio
  class Config
    attr_accessor :pinocchio_home
    attr_accessor :vagrant_home
    attr_accessor :module_path
    attr_accessor :manifests_path
    attr_accessor :manifest_file
    attr_accessor :timeout_seconds
    attr_accessor :boxes
    attr_accessor :exposed_ports
    attr_accessor :ssh

    # isolating this allows us to avoid worrying about collision with newer (non-gem) vagrant installs.
    # it has the net side-effect of also isolating the box space
    PINOCCHIO_HOME  = File.join(ENV['HOME'], '.pinocchio')
    # by default, vagrant looks in your spec/fixtures set up by puppetlabs_spec_helper
    MODULE_PATH     = File.join(Dir.pwd, 'spec', 'fixtures', 'modules')
    MANIFESTS_PATH  = File.join(Dir.pwd, 'spec', 'fixtures', 'manifests')
    MANIFEST_FILE   = 'pinocchio.pp'
    TIMEOUT_SECONDS = 300

    def initialize
      yield self if block_given?

      @pinocchio_home  ||= PINOCCHIO_HOME
      @vagrant_home    ||= File.join(@pinocchio_home, 'vagrant_home')
      @module_path     ||= MODULE_PATH
      @manifests_path  ||= MANIFESTS_PATH
      @manifest_file   ||= MANIFEST_FILE
      @timeout_seconds ||= TIMEOUT_SECONDS
      @boxes           ||= import_boxes
      @ssh             ||= :never

    end

    private

    def import_boxes
      boxes_yaml = File.join(File.expand_path '../../../boxes.yaml', __FILE__)
      return YAML.load_file(boxes_yaml)['boxes']
    end
  end
end