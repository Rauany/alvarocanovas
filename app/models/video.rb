class Video < ActiveRecord::Base

  default_scope :order => 'number'


  before_create {|video|
    video.number = video.class.maximum('number').to_i + 1
  }

  after_create { |video|
    video.upload(video.source.path) if video.source?
  }


  has_attached_file :source, :styles => {} 

  hosted_on_vimeo :account => :user

  belongs_to :user

  validates_attachment_presence :source


end


