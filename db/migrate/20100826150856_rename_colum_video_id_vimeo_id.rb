# -*- encoding : utf-8 -*-
class RenameColumVideoIdVimeoId < ActiveRecord::Migration
  def self.up
    rename_column :videos, :video_id, :vimeo_id
  end

  def self.down
  end
end
