module VideosHelper

  def vimeo_player(video)
    content_tag :class=> "vimeo_player" do
      content_tag :div, :class => "ajax-loader" do
        content_tag(:div, '')
      end +
      content_tag(:iframe, '', :src => video.vimeo_player_url, :height => 533, :width =>700)
    end
  end

end
