require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_password_changed
    assert user = User::OWNER
    user.password='io'
    debugger
    assert user.save
    assert User.find 
  end

end
