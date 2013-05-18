require 'pinocchio/version'
require 'pinocchio/api'
require 'vagrant/prison'

module Pinocchio
  def self.before
    Pinocchio.vagrant_init
  end

  def self.after
    begin
      @vagrant.cleanup
    rescue
    end
  end
end
