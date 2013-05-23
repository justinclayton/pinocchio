require 'cucumber/rspec/doubles'
require 'pinocchio'
require 'pinocchio/cucumber'

Pinocchio.config do |p|
  p.exposed_ports = ['6379']
end
