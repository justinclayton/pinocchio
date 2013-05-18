# pinocchio/rake
require 'rake'
require 'puppetlabs_spec_helper/rake_tasks'

desc 'Test cucumber features'
task :features do
  Rake::Task[:spec_prep].invoke
  Rake::Task[:features_standalone].invoke
  Rake::Task[:spec_clean].invoke
end

task :features_standalone do
  sh 'cucumber features/*.feature'
end