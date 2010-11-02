class AddActiveToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :active, :boolean, :default => true 
  end

  def self.down
  end
end
