$:.insert 0, File.join(File.dirname(__FILE__), "..", "lib")
require 'rubygems'
require 'merb-core'
require 'spec'
require 'spec/mocks'
dependency 'sequel'
require 'merb-core/test'
require 'merb-core/test/helpers'

require File.join( File.dirname(__FILE__), "..", "lib", 'merb_sequel')

Merb.start :environment => 'test',
           :adapter => 'runner',
           :session_store => 'sequel',
           :merb_root => File.dirname(__FILE__)

# Load extensions if we use new versions of Sequel
require 'sequel/extensions/migration' if /^(2.12|3)/ =~ Sequel.version

Spec::Runner.configure do |config|
  config.include Merb::Test::RequestHelper
end

Merb::Router.prepare do
  default_routes
end

require File.join( File.dirname(__FILE__), 'spec_model')
require File.join( File.dirname(__FILE__), 'spec_controller')
