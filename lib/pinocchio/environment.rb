# pinocchio/environment
require 'yaml'

module Pinocchio
  class Environment
    attr_accessor :config

    def initialize(config = Config.new)
      @config = config
    end
  end
end