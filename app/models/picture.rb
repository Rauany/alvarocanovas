class Picture < ActiveRecord::Base

  order_collection_by :number, :asc, :new_instance => :end, :parent => :category

  belongs_to :category


  has_attached_file :image,
                    :styles => {
                      :admin => ['50x50','jpg'],  
                      :small => ['80x60>', 'jpg'],
                      :large => ['800x533><', 'jpg']
                    }
  

  validates_attachment_presence :image


end
