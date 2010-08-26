class AddVimeoInfoToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :vimeo_info, :blob
  end

  def self.down
  end
end
