require File.join( File.dirname(__FILE__), '..', 'spec_helper')

describe "Resource" do
  
  it "should provide documentation" do
    get '/resource.html'
    last_response.should be_ok
  end
  
  it "should say hello world." do
    get '/resource'
    last_response.should be_ok
    resp = JSON.parse( last_response.body)
    resp['hello'].should eq('world')
  end
  
end
