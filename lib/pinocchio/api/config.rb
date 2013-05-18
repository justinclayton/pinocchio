# pinocchio/api/config
module Pinocchio
  # by default, vagrant looks in your spec/fixtures set up by puppetlabs_spec_helper
  MODULE_PATH            = File.join(Dir.pwd, 'spec', 'fixtures', 'modules')
  MANIFESTS_PATH         = File.join(Dir.pwd, 'spec', 'fixtures', 'manifests')
  MANIFEST_FILE          = 'pinocchio.pp'
  TIMEOUT_SECONDS        = 300
  ## XXX: write code to allow for array here
  BOXES                  = nil
  EXPOSED_PORTS          = nil

  def self.module_path
    @module_path or MODULE_PATH
  end

  def self.module_path=(value)
    @module_path = value or MODULE_PATH
  end

  def self.manifests_path
    @manifests_path or MANIFESTS_PATH
  end

  def self.manifests_path=(value)
    @manifests_path = value or MANIFESTS_PATH
  end

  def self.manifest_file
    @manifest_file or MANIFEST_FILE
  end

  def self.manifest_file=(value)
    @manifest_file = value or MANIFEST_FILE
  end

  def self.timeout_seconds
    @timeout_seconds or TIMEOUT_SECONDS
  end

  def self.timeout_seconds=(value)
    @timeout_seconds = value or TIMEOUT_SECONDS
  end

  def self.boxes
    @boxes or BOXES
  end

  def self.boxes=(value)
    @boxes = value or BOXES
  end

  def self.exposed_ports
    @exposed_ports or EXPOSED_PORTS
  end

  def self.exposed_ports=(value)
    @exposed_ports = value or EXPOSED_PORTS
  end

end