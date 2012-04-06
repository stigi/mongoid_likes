# -*- encoding: utf-8 -*-

# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'mongoid_likes/version'

Gem::Specification.new do |s|
  s.name        = 'mongoid_likes'
  s.version     = Mongoid::Likes::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Ullrich Schäfer']
  s.email       = ['ullrich@seidbereit.de']
  s.homepage    = 'https://github.com/stigi/mongoid_likes'
  s.summary     = %q{Add likeing ability to Mongoid documents}
  s.description = %q{Add liking ability to Mongoid documents. Also adds the inverse relation}

  s.add_development_dependency 'rspec', '~> 2.5'
  s.add_development_dependency 'rake', '~> 0.9'
  s.add_dependency 'mongoid', '~> 2.0'
  s.add_dependency 'bson_ext', '~> 1.4'
  s.add_dependency 'activesupport', '~> 3.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib', 'app']
end
