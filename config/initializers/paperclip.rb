#
#
#
##ActiveSupport.on_load(:active_record) do
#  module Paperclip
#    class Attachment
#      def url_with_uri_escape(*args)
#        URI.escape url_without_uri_escape(*args)
#      end
#      alias_method_chain :url, :uri_escape
#    end
#  end
##end
