# Load the Sinatra app
require File.join( File.dirname(__FILE__), '..', 'server' )

require 'rspec'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  MHDApp
end

