require 'cucumber/rspec/doubles'
require 'rake'
require 'pinocchio'
require 'pinocchio/cucumber'

# Pinocchio.boxes = ['centos6' => 'https://s3.amazonaws.com/justinclayton-pinocchio/boxes/centos6.box']
Pinocchio.exposed_ports = ['6379']


# pinocchio/cucumber/hooks
World(Pinocchio)

Before do
  Pinocchio.before
end

After do
  # Pinocchio.after
end
