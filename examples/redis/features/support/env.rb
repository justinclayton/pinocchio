require 'cucumber/rspec/doubles'
require 'rake'
require 'pinocchio'
require 'pinocchio/cucumber'

Pinocchio.boxes = ['centos6']
Pinocchio.exposed_ports = ['6379']


# pinocchio/cucumber/hooks
World(Pinocchio)

Before do
  Pinocchio.before
end

After do
  # Pinocchio.after
end
