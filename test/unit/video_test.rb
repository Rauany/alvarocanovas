require 'test_helper'



class VideoTest < ActiveSupport::TestCase
  FILES_PATH = File.join(Rails.root,'test/fixtures/files')
  RESPONSES_PATH = File.join(Rails.root,'test/fakeweb_responses')

  def setup
    @owner = User::OWNER
  end
  def teardown
    Delayed::Job.delete_all
  end

  def response_bodies(*file_names)
    file_names.flatten.collect do |file_name|
      {:body => File.join(RESPONSES_PATH, "#{file_name}.json")}
    end
  end
  
  def register_uri(method, uri, *file_names)
    FakeWeb.register_uri(method,uri, response_bodies(*file_names))
  end

  def test_create
    register_uri(:get,/vimeo/,"check_access")
    register_uri(:post, /vimeo/, 'get_quota', 'get_ticket', 'complete', 'video_advanced_info' )
    register_uri(:post, /upload_multi/, {:body => "0", :status => 200})
    
    video = @owner.videos.create(:source => File.open(File.join(FILES_PATH,"01.mp4")))
    Delayed::Worker.new.work_off
    assert_equal "1234567", video.reload.vimeo_id
    assert !video.vimeo_info.blank?
  end

end
