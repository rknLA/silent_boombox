class MHDApp

#########################    POST /boombox    #########################
  
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

#########################    POST /listener    #########################

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
    if params.include?('debug') and params[:debug]
      body listener.to_json
    end
  end

##############################    POST /song     ##############################

  post '/song' do     #add a song to the boombox!
    song = Song.first_or_create(
      :spotify_song_id  => params[:spotify_song_id],
      :boombox_id       => params[:boombox_id]
    )

    status 200
    body ''
    if params.include?('debug') and params[:debug]
      body song.to_json
    end
  end

##############################    GET /boombox    ##############################

  get '/boombox' do   #gets a boombox resource associated with a listener.
    listener = Listener.first(:spotify_id => params['spotify_id'])

    if listener
      result = {
        :boombox_id => listener.boombox_id
      }
      song = Song.first(:boombox_id => listener.boombox_id)
      if song
        result[:spotify_song_id] = song.spotify_song_id
      else
        result[:spotify_song_id] = nil
      end
    else
      result = {
        :boombox_id       => nil,
        :spotify_song_id  => nil
      }
    end

    result.to_json
  end

##############################    POST /buffered    ##############################

  post '/buffered' do
    listener = Listener.first(
      :spotify_id => params[:spotify_id],
      :boombox_id => params[:boombox_id]
    )

    unless listener
      status 400
      result = {
        :error => 'Invalid listener parameters provided',
        :params => params
      }.to_json
    else
      listener.buffered = true;
      listener.save

      body ''

      if params.include?('debug') and params[:debug]
        body listener.to_json
      end
    end
  end

##############################    GET /sync    ##############################

  get '/sync' do
    all_ready = true

    listeners = Listener.all(:boombox_id => params[:boombox_id])
    listeners.each do |listener|
      unless listener.buffered
        all_ready = false
        break
      end
    end

    if all_ready
      boombox = Boombox.first(:boombox_id => params[:boombox_id])

      unless boombox.sync_time
        boombox.sync_time = params[:boombox_id] + (5 * 1000)
        boombox.save
      end
      boombox.to_json
    else
      ''
    end
  end
end
