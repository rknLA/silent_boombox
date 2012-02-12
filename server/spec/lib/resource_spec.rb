require File.join( File.dirname(__FILE__), '..', 'spec_helper')

describe "Boombox" do

  it "should return an ID and a listener ID when created" do
    post '/boombox'
    last_response.should be_ok
    result = JSON.parse(last_response.body)
    has_id = result.include? 'id'
    has_id.should_be true
    has_listener_id = result.include? 'listener_id'
    has_listener_id.should_be true
  end

end


