# -*- encoding : utf-8 -*-
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def test_validation
    c = Category.new(:title => 'io')
    assert_equal false, c.save
    assert_match /French description/, c.errors.full_messages.to_s
    assert_match /English description/, c.errors.full_messages.to_s
  end
end
