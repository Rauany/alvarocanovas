# -*- encoding : utf-8 -*-
class Picture < ActiveRecord::Base

  order_collection_by :number, :asc, :new_instance => :end, :parent => :category

  belongs_to :category


  has_attached_file :image,
                    :styles => {
                      :admin => ['x33','jpg'],
                      :medium => ["x60",'jpg'],
                      :small => ['x50', 'jpg'],
                      :large => ['x533', 'jpg']
                    }
  

  validates_attachment_presence :image


end
