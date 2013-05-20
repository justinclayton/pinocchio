require 'cucumber/rspec/doubles'
require 'rake'
# require 'pinocchio'
require 'pinocchio/cucumber'

# Pinocchio.boxes = ['centos6' => 'https://s3.amazonaws.com/justinclayton-pinocchio/boxes/centos6.box']
Pinocchio.exposed_ports = ['6379']


#Before do
#  Pinocchio.before
#end
