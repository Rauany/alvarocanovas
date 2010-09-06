require 'test_helper'



class VideoTest < ActiveSupport::TestCase
  FILES_PATH = File.join(Rails.root,'test/fixtures/files')
  RESPONSES_PATH = File.join(Rails.root,'test/fakeweb_responses')

  def setup
    @owner = User.find_by_name('owner')
  end


end
