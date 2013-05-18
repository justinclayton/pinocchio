require 'redis'

Then /^I should be able to connect to the redis server$/ do
  @redis = Redis.new(:host => 'localhost', :port => 7379 )
  @redis.ping.should == "PONG"
end

Then /^I should be able to store data in redis$/ do
  @redis.set('abc', 'Hello World')
end

Then /^I should be able to retrieve data from redis$/ do
  @redis.get('abc').should == 'Hello World'
end

After do
  begin
    @redis.flushall
  rescue
  end
end