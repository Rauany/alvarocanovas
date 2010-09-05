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


end
