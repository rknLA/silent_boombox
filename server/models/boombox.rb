require 'data_mapper'

class Boombox
  include DataMapper::Resource

  property :id,               Serial
  property :dj_listener_id,   Integer
  property :sync_time,        DateTime
  property :created_at,       DateTime

  has n, :listeners
end

class Listener
  include DataMapper::Resource

  property :id,               Serial
  property :spotify_id,       String
  property :boombox_id,       Integer
  property :buffered,         Boolean,    :default => false

  belongs_to :boombox
end

class Song
  include DataMapper::Resource

  property :id,               Serial
  property :spotify_song_id,  String
  property :boombox_id,       Integer
end

 
