# -*- encoding : utf-8 -*-
class AddNumberToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :number, :integer

  end

  def self.down
    remove_column :videos, :number
  end
end
