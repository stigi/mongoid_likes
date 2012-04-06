# encoding: utf-8

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => [:spec]


require 'jeweler'
require 'mongoid_likes/version'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "mongoid_likes"
  gem.summary = %Q{Add likeing ability to Mongoid documents}
  gem.description = %Q{Add liking ability to Mongoid documents. Also adds the inverse relation}
  gem.email = "ullrich@seidbereit.de"
  gem.homepage = "http://github.com/stigi/mongoid_likes"
  gem.authors = ['Ullrich Schäfer']

  gem.version     = Mongoid::Likes::Version::STRING
  gem.platform    = Gem::Platform::RUBY
  
  gem.add_development_dependency 'rspec', '~> 2.5'
  gem.add_development_dependency 'mongoid', '~> 2.0'
  gem.add_development_dependency 'bson_ext', '~> 1.4'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib', 'app']
end
Jeweler::RubygemsDotOrgTasks.new
