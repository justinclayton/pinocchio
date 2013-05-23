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

    # by default, vagrant looks in your spec/fixtures set up by puppetlabs_spec_helper
    MODULE_PATH     = File.join(Dir.pwd, 'spec', 'fixtures', 'modules')
    MANIFESTS_PATH  = File.join(Dir.pwd, 'spec', 'fixtures', 'manifests')
    MANIFEST_FILE   = 'pinocchio.pp'
    TIMEOUT_SECONDS = 300
    # isolating this allows us to avoid worrying about collision with newer (non-gem) vagrant installs.
    # it has the net side-effect of also isolating the box space
    VAGRANT_HOME    = File.join(ENV['HOME'], '.pinocchio', 'vagrant_home')

    def initialize
      yield self if block_given?

      @vagrant_home    ||= VAGRANT_HOME
      @module_path     ||= MODULE_PATH
      @manifests_path  ||= MANIFESTS_PATH
      @manifest_file   ||= MANIFEST_FILE
      @timeout_seconds ||= TIMEOUT_SECONDS
      @boxes           ||= import_boxes

    end

    private

    def import_boxes
      boxes_yaml = File.join(File.expand_path '../../../boxes.yaml', __FILE__)
      # boxes_yaml = File.expand_path(File.join(Dir.pwd, 'boxes.yaml'))
      return YAML.load_file(boxes_yaml)['boxes']
    end
  end
end