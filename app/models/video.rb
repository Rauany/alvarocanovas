class Video < ActiveRecord::Base


  has_attached_file :source



  validates_attachment_presence :source



end


