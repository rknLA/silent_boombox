require File.join( File.dirname(__FILE__), '..', 'spec_helper')

describe "Boombox" do

  it "should return an ID and a listener ID when created" do
    post '/boombox'
    last_response.should be_ok
    result = JSON.parse(last_response.body)
    result.include?('boombox_id').should be_true
    result.include?('listener_id').should be_true
  end

end


