require 'pinocchio/config'
require 'pinocchio/environment'
require 'pinocchio/vm'
require 'pinocchio/version'

module Pinocchio
  def self.config
    @config = Pinocchio::Config.new do |env|
      yield env if block_given?
    end
  end

  def self.init
    @config    = Pinocchio::Config.new unless @config
    @pinocchio = Pinocchio::Environment.new(@config)

    ENV['VAGRANT_HOME'] = @pinocchio.config.vagrant_home

    # XXX: placeholder return value?
    return @pinocchio
  end
end
