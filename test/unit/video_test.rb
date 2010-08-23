require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  FILES_PATH = File.join(Rails.root,'test/fixtures/files')

  def setup
#    system "RAILS_ENV=#{Rails.env} script/delayed_job restart"
  end

  def test_video_is_converted_to_flv
  end

end
