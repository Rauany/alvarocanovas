class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable

  has_vimeo_account

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :first_name, :last_name, :address, :city, :country, :phone_number, :email, :password, :password_confirmation, :remember_me

  def full_name
    [first_name.to_s, last_name.to_s.upcase].join(' ')
  end

  def synchronize_videos_with_vimeo(force=false)
    destroy_videos_deleted_on_vimeo do
      vimeo_instances.collect do |instance|
        video = Video.find_or_initialize_by_vimeo_id(instance['id'])
        video.title = instance['title']
        video.save(force)
        video
      end
    end
    videos(true)
  end

  def destroy_videos_deleted_on_vimeo(&user_videos_on_vimeo)
    (videos - user_videos_on_vimeo.call).map(&:destroy)
  end

end
