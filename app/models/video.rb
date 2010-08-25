class Video < ActiveRecord::Base


  has_attached_file :source

  has_vimeo_instance :account_belongs_to => :user
  
  validates_attachment_presence :source

  after_post_process :send_to_vimeo




end


