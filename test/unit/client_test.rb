# -*- encoding : utf-8 -*-
require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  def test_validation
    c = Client.new(:title => 'io')
    assert_equal false, c.save
    assert_no_match /French description/, c.errors.full_messages.to_s
    assert_no_match /English description/, c.errors.full_messages.to_s
  end

end
