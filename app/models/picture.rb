class Picture < ActiveRecord::Base

  default_scope :order => 'number'

  before_create {|picture|
    picture.number = picture.class.maximum('number').to_i + 1
  }

  belongs_to :category


  has_attached_file :image,
                    :styles => {
                      :admin => ['50x50','jpg'],  
                      :small => ['80x60>', 'jpg'],
                      :large => ['800x533><', 'jpg']
                    }
  

  validates_attachment_presence :image


end
