require 'sinatra'
require 'sinatra/activerecord'


post '/boombox' do
  #create a new boombox as the dj

end

post '/listener' do
  #add a listener to an existing boombox

end

post '/song' do
  #add a song to an existing boombox
  
end

get '/boombox' do
  #get a boombox that i've been added to (as a listener)

end

post '/buffering' do
  #notify the server that a listener has begun to buffer a song
  
end

get '/sync' do
  #get the UTC timestamp of when to begin a song, assuming all of the necessary conditions are met.

end





