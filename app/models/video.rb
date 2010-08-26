class Video < ActiveRecord::Base


  has_attached_file :source

  hosted_on_vimeo :account => :user
  
  validates_attachment_presence :source

  after_post_process :send_to_vimeo




end


