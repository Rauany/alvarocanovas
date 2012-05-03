# -*- encoding : utf-8 -*-
class Message
  include ActiveModel::Validations
  include ActiveModel::Naming

  attr_accessor :attributes

  validates_presence_of :name, :email, :content, :phone

  [:name, :email, :content, :phone].each do |key|
    define_method key do
      self.attributes[key.to_sym]
    end
    define_method "#{key}=" do |value|
      self.attributes[key.to_sym]= value
    end
  end
  
  def initialize(attributes={})
    @attributes = attributes.symbolize_keys
  end

  def read_attribute_for_validation(key)
    @attributes[key.to_sym]
  end
  
  def to_key
    nil
  end

  
end
