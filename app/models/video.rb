class Video < ActiveRecord::Base


  has_attached_file :source, :styles => {} 

  hosted_on_vimeo :account => :user

  belongs_to :user

  validates_attachment_presence :source

  after_create { |video|
    video.delay.upload(video.source.path) if video.source?    
  }




end


