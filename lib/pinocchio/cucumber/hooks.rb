# pinocchio/cucumber/hooks

Before do
  @pinocchio = Pinocchio.init
end


After do |scenario|

  if (@vm.config.ssh == :always) or (@vm.config.ssh == :on_fail and scenario.failed?)
    @vm.exec_ssh
  else
    @vm.vagrant_env.cleanup
  end
end