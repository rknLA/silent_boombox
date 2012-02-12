require 'data_mapper'
class Boombox
  include DataMapper::Resource

  property :id,               Serial
  property :dj_listener_id,   Integer
  property :sync_time,        DateTime

end

class Listener
  include DataMapper::Resource

  property :id,               Serial
  property :spotify_id,       String
  property :boombox_id,       Integer
  property :buffered,         Boolean,    :default => false

  validates_uniqueness_of :spotify_id, :scope => :boombox_id,
    :message => "Listener already added to boombox"
end

class Song
  include DataMapper::Resource

  property :id,               Serial
  property :spotify_song_id,  String
  property :boombox_id,       Integer,    :required => true
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/musichackday')
DataMapper.finalize
DataMapper.auto_upgrade!

