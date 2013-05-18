require 'spec_helper'

describe 'redis', :type => :class do
  it do
    should include_class('epel')
    should contain_package('redis').with_ensure('installed')
    should contain_file('/etc/redis.conf').with_ensure('file')
    should contain_service('redis').with_ensure('running')
  end
end