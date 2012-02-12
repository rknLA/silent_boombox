require File.join( File.dirname(__FILE__), '..', 'spec_helper')

describe "Listener Request Flow" do

  before :all do
    DataMapper.auto_migrate!
  end

  #get /boombox
  it "should not return a boombox if a dj's not added me" do
    get '/boombox',
      :spotify_id => 'rknLA'
    last_response.should be_ok
    result = JSON.parse(last_response.body)
    result.include?('boombox_id').should be_true
    result.include?('spotify_song_id').should be_true
    result['boombox_id'].should be_nil
    result['spotify_song_id'].should be_nil
  end

  it "should return a boombox if a dj's added me" do
    post '/boombox',
      :spotify_id => '1217777582'
    result = JSON.parse(last_response.body)
    @boombox_id = result['boombox_id']
    post '/listener',
      :boombox_id => @boombox_id,
      :spotify_id => 'rknLA'

    get '/boombox',
      :spotify_id => 'rknLA'
    last_response.should be_ok
    result = JSON.parse(last_response.body)
    result['boombox_id'].should == @boombox_id
    result['spotify_id'].should be_nil
  end

  
  it "should return a boombox and a song if a dj's added me and picked one" do
    post '/boombox',
      :spotify_id => 'a_Fake_spotify_name'
    result = JSON.parse(last_response.body)
    @boombox_id = result['boombox_id']

    post '/listener',
      :boombox_id => @boombox_id,
      :spotify_id => 'another_fake_name'

    post '/song',
      :boombox_id => @boombox_id,
      :spotify_song_id => 'spotify:track:6wRSFdxXTPeM7uMWaWrIVX',
      :debug => true
    last_response.should be_ok

    get '/boombox',
      :spotify_id => 'another_fake_name'
    last_response.should be_ok
    result = JSON.parse(last_response.body)
    result['boombox_id'].should == @boombox_id
    result['spotify_song_id'].should == 'spotify:track:6wRSFdxXTPeM7uMWaWrIVX'
  end

end

