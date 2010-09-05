class Picture < ActiveRecord::Base

  belongs_to :category

  before_create {|picture|
    picture.number = picture.class.maximum('number').to_i + 1
  }

  has_attached_file :image,
                    :styles => {
                      :admin => ['50x50','jpg'],  
                      :small => ['80x60>', 'jpg'],
                      :large => ['800x533><', 'jpg']
                    }
  
  default_scope :order => 'number'

  validates_attachment_presence :image


end
