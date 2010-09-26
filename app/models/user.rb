class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable

#  cache_constants :name

#  has_many :videos, :hosted_on => :vimeo

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
#  attr_accessible :name, :first_name, :last_name, :address, :city, :country, :phone_number, :email, :password, :password_confirmation, :remember_me

  def full_name
    [first_name.to_s, last_name.to_s.upcase].join(' ')
  end

end
