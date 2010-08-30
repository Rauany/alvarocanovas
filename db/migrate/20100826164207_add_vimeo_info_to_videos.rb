class AddVimeoInfoToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :vimeo_info_local, :blob
  end

  def self.down

  end
end
