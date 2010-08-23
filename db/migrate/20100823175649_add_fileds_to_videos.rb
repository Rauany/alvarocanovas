class AddFiledsToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :description, :text
    add_column :videos, :embed, :text
    add_column :videos, :video_id, :string
  end

  def self.down
  end
end
