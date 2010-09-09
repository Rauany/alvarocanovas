module VideosHelper

  def vimeo_player(video)
    content_tag :div, :class=> "vimeo_player" do
      content_tag(:div, content_tag(:div, "&nbsp"), :class => "ajax-loader") + content_tag(:iframe, "&nbsp", :src => video.vimeo_player_url, :height => 533, :width =>700)
    end
  end

end
