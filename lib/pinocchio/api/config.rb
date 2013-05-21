# pinocchio/api/config
require 'yaml'

module Pinocchio

  def self.vagrant_home
    @vagrant_home or VAGRANT_HOME
  end

  def self.vagrant_home=(value)
    @vagrant_home = value or VAGRANT_HOME
  end

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

  def self.import_boxes
    boxes_yaml = File.join(File.expand_path '../../../../boxes.yaml', __FILE__)
    return YAML.load_file(boxes_yaml)['boxes']
  end

end