require 'logger'

module Sinatra
  module Pushr
    module Adapters
      class EmailAdpater < BaseAdpater
        def initialize
          @log = Logger.new($stdout)
        end
        def send_message(dest, title, message)
          @log.info("send(#{dest}) -> #{title}: #{message}")
        end
        
        register self
      end
    end
  end
end
