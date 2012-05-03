# -*- encoding : utf-8 -*-
class AddVimeoIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :vimeo_id, :text
  end

  def self.down
  end
end
