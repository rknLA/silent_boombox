class MHDApp
  
  post '/boombox' do    #create a new boombox!
    listener = Listener.create(
      :spotify_id   => params[:spotify_id]
    )
    bb = Boombox.create(
      :dj_listener_id   =>  listener.id,
    )
    listener.update(:boombox_id => bb.id)

    response = {
      :boombox_id => bb.id,
      :listener_id => listener.id
    }

    response.to_json
  end


  post '/listener' do   #add a listener to a boombox!
    listener = Listener.create(
      :spotify_id     => params[:spotify_id],
      :boombox_id     => params[:boombox_id]
    )

    if listener.valid?
      status 200
      body ''
    else
      status 400
      body 'Listener could not be created'
    end
  end

  get '/resource.html' do
    erb :'resource'
  end
  
  get '/resource' do
    content_type :json

    response = { :hello => "world" }

    response.to_json
  end
end
