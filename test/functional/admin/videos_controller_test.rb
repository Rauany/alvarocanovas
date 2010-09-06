require 'test_helper'

class Admin::VideosControllerTest < ActionController::TestCase
  FILES_PATH = File.join(Rails.root,'test/fixtures/files')

  def setup
    @user = User.find_by_email("nicolas.papon@w3bflows.com")
    sign_in @user
  end

  def test_create
    register_uri(:get,/vimeo/,"check_access")
    register_uri(:post, /vimeo/, 'get_quota', 'get_ticket', 'complete', 'video_advanced_info_transcoding' )
    register_uri(:post, /upload_multi/, {:body => "0", :status => 200})

    params = {
        :video => {
            :title => 'io io nico',
            :source => File.open(File.join(FILES_PATH,"01.mp4"))
        }
    }
    assert_difference "Video.count" do
      post :create, params
      assert_equal 'io io nico', assigns(:video).title
    end

  end
end
