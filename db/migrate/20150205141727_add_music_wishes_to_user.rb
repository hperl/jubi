class AddMusicWishesToUser < ActiveRecord::Migration
  def change
    add_column :users, :music_wishes, :text, default: ''
  end
end
