# -*- encoding : utf-8 -*-
class AddLinkToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :link, :string
  end

  def self.down
  end
end
