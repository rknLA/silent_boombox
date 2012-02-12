require 'json'

class MHDApp < Sinatra::Application

  def ensure_connections
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, 'mysql://localhost/silent_boombox')
    DataMapper.finalize
  end

  before do
    ensure_connections
    
    @errors = {} # empty error response. see #after for how this gets handled.
  end

  def errors?
    @errors.keys.length > 0
  end
  
  after do
    halt_with_errors! if errors?
  end

end

# load in all of the other .rb files in this directory
Dir[ File.join( File.dirname(__FILE__), '*.rb') ].each { |f| require f }
