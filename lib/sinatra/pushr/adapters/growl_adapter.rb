require 'logger'
require 'ruby-growl'

module Sinatra
  module Pushr
    module Adapters
      class GrowlAdapter < BaseAdapter
        def initialize
          @log = Logger.new($stdout)
        end

        def send_message(dest, title, message)
          @log.info("send(#{dest}) -> #{title}: #{message}")
          g = Growl.new dest, "pushr", ["pushr notification"]
          g.notify "pushr notification", title, message
        end
        
        register self
      end
    end
  end
end
