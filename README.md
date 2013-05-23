# Pinocchio

Automating real behavior testing of your Puppet modules with Cucumber + Vagrant. Also, magic.

## Installation

Add this line to your application's Gemfile:

    gem 'pinocchio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pinocchio

## Usage

Add this to your module's `Rakefile`:

    require 'pinocchio/rake'
    
And this to your module's `features/support/env.rb`:

	require 'pinocchio/cucumber'
	
If you will be testing network connections, you will need to specify what ports to expose to your machine in your `env.rb` as well, like this:

	Pinocchio.config do |config|
	  config.exposed_ports = ['80', '443']
	end

Look at the provided test puppet module for a complete example of usage.

## Assumptions

Pinocchio is a stupid wooden puppet, and therefore makes many assumptions about your workflow:


- He assumes you already do spec tests using the `puppetlabs_spec_helper` gem, as he relies on `.fixtures.yml` to understand your module's dependencies. This may change in the future.

- He doesn't like sharing, so when he downloads and uses Vagrant boxes, they don't go in `$VAGRANT_HOME` (aka `~/.vagrant.d`), but instead in `~/.pinocchio/vagrant_home`. You can override `vagrant_home` and many other config elements inside of the `Pinocchio.config` block.

- He assumes you like cucumbers. That's why he brought you all these cucumbers. He just wants you to love him!

## Contributing

1. Fork it

2. Create your feature branch (`git checkout -b my-new-feature`)

3. Commit your changes (`git commit -am 'Add some feature'`)

4. Push to the branch (`git push origin my-new-feature`)

5. Wish upon a star

5. Create new Pull Request
