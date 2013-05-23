# pinocchio/cucumber/steps

## XXX: must support scenario outlines here
Given(/^an? (.+) machine$/) do |box_name|
  @vm = Pinocchio::VM.new(box_name, @pinocchio.config)
  @vm.up
end

## XXX: currently only supports one test manifest; rework to support more
When(/^I apply the (.+) module$/) do |module_name|
  # look in module_name/tests/init.pp
  test_manifest = File.join(@pinocchio.config.module_path, module_name, 'tests', 'init.pp')
  @vm.apply_test test_manifest
end