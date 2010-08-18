require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  def test_create
    params = {
      :message => {
        :name => 'nicolas',
        :email => 'nicolas@gmail.com',
        :content => 'text',
        :phone => '06'
      }
    }
    assert_difference "MessageMailer.deliveries.size" do
      xhr :post, :create, params
    end

    email = MessageMailer.deliveries.last

    params[:message].each do |k,v|
      assert_match Regexp.new(v), email.body.to_s
    end
  end

  def test_validation
    params = {
      :message => {
        :name => 'nicolas',
        :content => 'text',
        :phone => '06'
      }
    }
    assert_no_difference "MessageMailer.deliveries.size" do
      xhr :post, :create, params
    end
    assert_match /be blank/, response.body
  end

end
