require 'cucumber/rspec/doubles'
require 'pinocchio'
require 'pinocchio/cucumber'

Pinocchio.config do |p|
  p.exposed_ports = ['6379']
  p.destroy_vm_on_test_fail = false
end
