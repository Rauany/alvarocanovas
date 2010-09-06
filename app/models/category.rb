class Category < ActiveRecord::Base
  default_scope :order => 'number'

  before_create {|category|
    category.number = Category.count + 1
  }


  has_many :pictures, :dependent => :destroy


  has_attached_file :image,
                    :styles => {
                      :small => ['50x50', :jpg], #{ :geometry => '50x50',   :quality => 40, :format => 'JPG'},
                      :large => ['200x200', :jpg] #{ :geometry => '200x200', :quality => 80, :format => 'JPG'}
                    }

  validates_attachment_presence :image

  validates_presence_of :title, :description, :description_fr, :if => Proc.new{|instance|
    instance.class.name == "Category"
  }

  def description(locale=:en)
    if locale.to_s == 'en'
      read_attribute(:description)
    else locale.to_s == 'fr'
      description_fr
    end
  end
  
end
