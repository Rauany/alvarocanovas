# -*- encoding : utf-8 -*-
require 'test_helper'

class MessageTest <  ActiveModel::TestCase

  def test_initialize
    params = {
        :name => 'nicolas',
        :email => 'nicolas@gmail.com',
        :content => 'text',
        :phone => '06'
    }
    message = Message.new(params)
    params.each do |k,v|
      assert_equal v, message.send(k)
    end
  end

  def test_validation
    params = {
        :name => 'nicolas',
        :email => 'nicolas@gmail.com',
        :content => 'text'
    }
    message = Message.new(params)
    assert_equal false, message.valid?
    message.phone="0672332684"
    assert_equal true, message.valid?
  end

  def test_error_message
    params = {
        :name => 'nicolas',
        :email => 'nicolas@gmail.com',
        :content => 'text'
    }
    message = Message.new(params)
    assert_equal false, message.valid?
    assert_match /Phone can't be blank/, message.errors.full_messages.to_s
  end
  
end
