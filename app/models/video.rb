class Video < ActiveRecord::Base


  has_attached_file :source

  validates_attachment_presence :source

  after_post_process :send_to_vimeo

  def send_to_vimeo
    ticket = user.vimeo_upload.get_ticket['ticket']
    user.vimeo_upload.upload(source.path,ticket['id'], ticket['endpoint'])
    user.vimeo_upload.complete(ticket['id'])

  end              vimeo.videos.upload.getTicket

  def oembed
    oembed = "http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/" + video_id.to_s
    HTTParty.get(oembed)['html']
  end

  def


end


