require 'rubygems'
require 'bundler'
Bundler.setup


require 'mongoid'
models_folder = File.join(File.dirname(__FILE__), 'mongoid/models')
Mongoid.configure do |config|
  name = 'mongoid_likes_test'
  host = 'localhost'
  config.master = Mongo::Connection.new.db(name)
  config.autocreate_indexes = true
end


$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'mongoid_likes'
require 'rspec'
require 'rspec/autorun'

Dir[ File.join(models_folder, '*.rb') ].each { |file|
  require file
  file_name = File.basename(file).sub('.rb', '')
  klass = file_name.classify.constantize
  klass.collection.drop
}
