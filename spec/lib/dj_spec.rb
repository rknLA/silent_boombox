require File.join( File.dirname(__FILE__), '..', 'spec_helper')

describe "DJ Request Flow" do

  before :all do
    DataMapper.auto_migrate!
  end

  after :all do

  end


  #post /boombox
  it "should return a boombox id and a listener id" do
    post '/boombox',
      :spotify_id => 'rknLA'
    last_response.should be_ok
    result = JSON.parse(last_response.body)
    result.include?('boombox_id').should be_true
    result.include?('listener_id').should be_true
    @boombox_id = result['boombox_id']
    @dj_id = result['listener_id']
  end
  
  #post /listener x3
  it "should be able to add a listener by spotify_id" do
    post '/boombox',
      :spotify_id => 'rknLA'
    result = JSON.parse(last_response.body)
    @boombox_id = result['boombox_id']

    post '/listener',
      :boombox_id => @boombox_id,
      :spotify_id => '1217777582'
    last_response.should be_ok
  end

  #post /song
  it "should be able to add a song by spotify song url" do
    post '/boombox',
      :spotify_id => 'rknLA'
    result = JSON.parse(last_response.body)
    @boombox_id = result['boombox_id']

    post '/listener',
      :boombox_id => @boombox_id,
      :spotify_id => '1217777582'

    post '/song',
      :boombox_id => @boombox_id,
      :spotify_song_id => 'spotify:track:6wRSFdxXTPeM7uMWaWrIVX',
      :debug => true
    last_response.should be_ok

  end

  #post /buffered
  it "should acknowledge the /buffered request" do
    post '/boombox',
      :spotify_id => 'rknLA'
    result = JSON.parse(last_response.body)
    @boombox_id = result['boombox_id']

    post '/listener',
      :boombox_id => @boombox_id,
      :spotify_id => '1217777582'

    post '/song',
      :boombox_id => @boombox_id,
      :spotify_song_id => 'spotify:track:6wRSFdxXTPeM7uMWaWrIVX'

    post '/buffered',
      :boombox_id => @boombox_id,
      :spotify_id => 'rknLA'
    last_response.should be_ok
  end

  #get /sync until result has UTC
  it "should not sync until all listeners have buffered" do
    post '/boombox',
      :spotify_id => 'rknLA'
    result = JSON.parse(last_response.body)
    @boombox_id = result['boombox_id']

    post '/listener',
      :boombox_id => @boombox_id,
      :spotify_id => '1217777582'

    post '/song',
      :boombox_id => @boombox_id,
      :spotify_song_id => 'spotify:track:6wRSFdxXTPeM7uMWaWrIVX'

    post '/buffered',
      :boombox_id => @boombox_id,
      :spotify_id => 'rknLA'
    last_response.should be_ok

    get '/sync',
      :boombox_id => @boombox_id
    last_response.should be_ok 
    last_response.body.should == ''
  end

  it "should return a UTC timestamp after all users have buffered" do
    post '/boombox',
      :spotify_id => 'rknLA'
    result = JSON.parse(last_response.body)
    @boombox_id = result['boombox_id']

    post '/listener',
      :boombox_id => @boombox_id,
      :spotify_id => '1217777582'

    post '/song',
      :boombox_id => @boombox_id,
      :spotify_song_id => 'spotify:track:6wRSFdxXTPeM7uMWaWrIVX'

    post '/buffered',
      :boombox_id => @boombox_id,
      :spotify_id => 'rknLA'
    last_response.should be_ok

    get '/sync',
      :boombox_id => @boombox_id,
      :current_time => '1234'
    last_response.should be_ok 
    last_response.body.should == ''

    post '/buffered',
      :boombox_id => @boombox_id,
      :spotify_id => '1217777582'
    last_response.should be_ok 
    
    get '/sync',
      :boombox_id => @boombox_id,
      :current_time => '1234'
    last_response.should be_ok 
    result = JSON.parse(last_response.body)
    result.include?('sync_time').should be_true
    result['sync_time'].should == 6234

  end

end


