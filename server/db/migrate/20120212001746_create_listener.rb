class CreateListener < ActiveRecord::Migration
  def self.up
    create_table :listeners do |t|
      t.string  :spotify_id
      t.integer :boombox_id
    end

    add_index :listeners, :spotify_id
  end

  def self.down
    drop_table :listeners
  end
end
