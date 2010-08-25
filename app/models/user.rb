class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable

  #has_vimeo_account

  has_many :videos

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :first_name, :last_name, :address, :city, :country, :phone_number, :email, :password, :password_confirmation, :remember_me

  def full_name
    [first_name.to_s, last_name.to_s.upcase].join(' ')
  end

  def synchronize_videos_with_vimeo(force=false)
    destroy_videos_deleted_on_vimeo do
      vimeo_instances_ids.collect do |vimeo_id|
        video = Video.init_from_vimeo(vimeo_id)
        video.user_id = id
        video.save
        video
      end
    end
    videos(true)
  end

  def destroy_videos_deleted_on_vimeo(&user_videos_on_vimeo)
    (videos - user_videos_on_vimeo.call).map(&:destroy)
  end

end
