module VideosHelper

  def vimeo_player(video)
    content_tag :iframe, '', :src => video.vimeo_player_url, :class=> "vimeo_player", :height => 533, :width =>700
  end

end
