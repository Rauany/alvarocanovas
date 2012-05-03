# -*- encoding : utf-8 -*-
class AddTypeToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :type, :string 
  end

  def self.down
  end
end
