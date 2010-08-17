class AddTypeToPhotographies < ActiveRecord::Migration
  def self.up
    add_column :pictures, :type, :string
  end

  def self.down
  end
end
