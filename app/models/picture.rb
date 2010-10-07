class Picture < ActiveRecord::Base

  order_collection_by :number, :asc, :new_instance => :end, :parent => :category

  belongs_to :category


  has_attached_file :image,
                    :styles => {
                      :admin => ['x33','jpg'],
                      :medium => ["x60",'jpg'],
                      :small => ['80x60!', 'jpg'],
                      :large => ['x533', 'jpg']
                    }
  

  validates_attachment_presence :image


end
