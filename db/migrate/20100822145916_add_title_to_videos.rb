class AddTitleToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :title, :string
  end

  def self.down
  end
end
