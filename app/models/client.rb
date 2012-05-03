# -*- encoding : utf-8 -*-
class Client < Category

  attachment_definitions[:image] = {
    :styles => {
      :small => ['x33', :jpg],
      :large => ['125', :jpg]
    }
  }

end
