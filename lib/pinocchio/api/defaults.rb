# pinocchio/api/defaults

module Pinocchio

  def self.import_boxes
    boxes_yaml = File.join(File.expand_path '../../../../boxes.yaml', __FILE__)
    return YAML.load_file(boxes_yaml)['boxes']
  end

  VAGRANT_HOME           = File.join(ENV['HOME'], '.pinocchio', 'vagrant_home')
  # by default, vagrant looks in your spec/fixtures set up by puppetlabs_spec_helper
  MODULE_PATH            = File.join(Dir.pwd, 'spec', 'fixtures', 'modules')
  MANIFESTS_PATH         = File.join(Dir.pwd, 'spec', 'fixtures', 'manifests')
  MANIFEST_FILE          = 'pinocchio.pp'
  TIMEOUT_SECONDS        = 300
  BOXES                  = Pinocchio.import_boxes
  EXPOSED_PORTS          = []
end