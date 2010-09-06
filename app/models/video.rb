class Video < ActiveRecord::Base

  default_scope :order => 'number'


  before_create {|video|
    video.number = video.class.maximum('number').to_i + 1
  }

  belongs_to :user

  hosted_on_vimeo :account => :user

  has_attached_file :source, :styles => {}

  validates_attachment_presence :source

  validates_presence_of :title

end


