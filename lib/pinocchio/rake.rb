# pinocchio/rake
require 'rake'
require 'puppetlabs_spec_helper/rake_tasks'

desc 'Test cucumber features'
task :features do
  Rake::Task[:cleanup_old_vms].invoke
  Rake::Task[:spec_prep].invoke
  Rake::Task[:features_standalone].invoke
  Rake::Task[:spec_clean].invoke
end

task :features_standalone do
  sh 'cucumber --expand features/*.feature'
end

## XXX: get this out of rake
desc 'Delete orphaned vms'
task :cleanup_old_vms do
  ## XXX: doesnt respect overrides for pinnochio_home
  file = File.expand_path("~/.pinocchio/orphaned")
  if File.exists? file
    orphaned_vms = File.readlines(file).each { |line| line.chomp! }
    orphaned_vms.each do |uuid|
      begin
        system("VBoxManage controlvm #{uuid} poweroff")
        system("VBoxManage unregistervm --delete #{uuid}")
      rescue
        puts "[warning] there was a problem deleting #{uuid}: you'll need to go into VirtualBox yourself to fix it."
      ensure
        ## XXX: should only remove vm from list if above was successful
        orphaned_vms.delete uuid
      end
    end
    File.open(file, 'w') { |f| f.puts orphaned_vms }
    File.delete(file) if File.zero?(file)
  end
end