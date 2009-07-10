require 'logger'
require 'restclient'

module Sinatra
  module Pushr
    module Adapters
      class TwitterAdapter < BaseAdapter
        def initialize
          @log = Logger.new($stdout)
        end
        
        def configure(options={})
          @protocol = options[:twitter_protocol] || ENV['TWITTER_PROTOCOL'] || "https"
          @user = options[:twitter_user] || ENV['TWITTER_USER']
          @pass = options[:twitter_pass] || ENV['TWITTER_PASS']

          raise ArgumentError.new("twitter protocol unknown, must be http or https") if (@protocol != "http" && @protocol != "https")
          raise ArgumentError.new("missing twitter user or password, please set environment variables TWITTER_USER and TWITTER_PASS") if (@user.nil? || @pass.nil?)
        end
        
        def send_message(dest, title, message)
          @log.info("send(#{dest}) -> #{title}: #{message}")
          RestClient.post "#{@protocol}://#{@user}:#{@pass}@twitter.com/direct_messages/new.json", :screen_name => dest, :text => message[0..139]
        end
        
        register self
      end
    end
  end
end
