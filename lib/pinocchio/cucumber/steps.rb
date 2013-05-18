# pinocchio/cucumber/steps

## XXX: must support scenario outlines here
Given(/^an? (.+) machine$/) do |box_name|
  @box_name = box_name
  Pinocchio.vagrant_up @box_name
end

## XXX: currently only supports one test manifest; rework to support more
When(/^I apply the (.+) module$/) do |module_name|
  # look in module_name/tests/init.pp
  test_manifest = File.join(Pinocchio.module_path, module_name, 'tests', 'init.pp')
  Pinocchio.assign_test_manifest test_manifest
  Pinocchio.vagrant_provision @box_name
end