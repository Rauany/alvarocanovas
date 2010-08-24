class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :first_name, :last_name, :address, :city, :country, :phone_number, :email, :password, :password_confirmation, :remember_me

  def full_name
    [first_name.to_s, last_name.to_s.upcase].join(' ')
  end


  def vimeo_advanced(token=nil,secret=nil)
    @vimeo_advanced ||= Vimeo::Advanced::Base.new(vimeo_api_key, vimeo_api_secret, :token => token || vimeo_token, :secret => secret || vimeo_secret)
  end
  
  def vimeo_simple
    @vimeo_advanced ||= Vimeo::Simple::Base.new(vimeo_api_key, vimeo_api_secret)
  end

  def vimeo_check_advanced_access
    begin
      vimeo_advanced.check_access_token
    rescue Vimeo::Advanced::RequestFailed
      false      
    end
  end
end
