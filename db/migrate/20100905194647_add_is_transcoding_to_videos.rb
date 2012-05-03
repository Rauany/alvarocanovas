# -*- encoding : utf-8 -*-
class AddIsTranscodingToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :is_transcoding, :boolean
  end

  def self.down
    remove_column :videos, :is_transcoding
  end
end
