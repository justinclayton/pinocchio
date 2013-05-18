# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pinocchio/version'

Gem::Specification.new do |gem|
  gem.name          = "pinocchio"
  gem.version       = Pinocchio::VERSION
  gem.authors       = ["Justin Clayton"]
  gem.email         = ["justin@claytons.net"]
  gem.description   = %q{Write a gem description}
  gem.summary       = %q{Write a gem summary}
  gem.homepage      = "http://github.com/justinclayton/pinocchio.git"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
