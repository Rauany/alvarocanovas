class AddVimeoTokenToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :vimeo_api_key, :text
    add_column :users, :vimeo_api_secret, :text
    add_column :users, :vimeo_token, :text
    add_column :users, :vimeo_secret, :text
  end

  def self.down

  end
end
