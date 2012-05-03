# -*- encoding : utf-8 -*-
class Content < ActiveRecord::Base

  cache_constants :name

  has_attached_file :image,
                    :styles => {
                      :small => ['50x50!', :jpg],
                      :large => ['380x400', :jpg]
                    }

#  validates_attachment_presence :image
#  validates_presence_of :html, :html_fr

  def html(locale=:en)
    if locale.to_sym == :en
      read_attribute(:html)
    else locale.to_sym == :fr
      html_fr
    end
  end


end
