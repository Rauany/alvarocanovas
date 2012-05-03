# -*- encoding : utf-8 -*-
class AddTranslationsToModels < ActiveRecord::Migration
  def self.up
    add_column :contents, :html_fr, :text
    add_column :categories, :description_fr, :text
  end

  def self.down
    remove_column :contents, :html_fr
    remove_column :categories, :description_fr
  end
end
