require 'rubygems'
require 'logger'
require 'action_mailer'

class Notifier < ActionMailer::Base
  def email(sender, recipient, title, message)
    from sender
    recipients recipient
    subject title
    body :message => message
  end        
end

Notifier.delivery_method = :smtp
Notifier.template_root = "views"

module Sinatra
  module Pushr
    module Adapters
      class EmailAdapter < BaseAdapter
        def initialize
          @log = Logger.new($stdout)
        end

        def configure(options={})
          @log.info "configure email"
          @sender = options[:mail_from] || ENV['MAIL_FROM']
          @address = options[:email_address] || ENV['MAIL_ADDRESS']
          @port = options[:email_port] || ENV['MAIL_PORT']
          @user = options[:email_user] || ENV['MAIL_USER']
          @pass = options[:email_pass] || ENV['MAIL_PASS']
          @tls = options[:email_tls] || (ENV['MAIL_TLS_ENABLED'] == "true")
          
          Notifier.smtp_settings = {
            :address        => @address,
            :port           => @port,
            :user_name      => @user,
            :password       => @pass,
            :authentication => :plain,
            :tls            => @tls
          }
          raise ArgumentError.new("missing config, please set environment variables MAIL_FROM, MAIL_ADDRESS, MAIL_PORT, MAIL_USER and MAIL_PASS") if (@sender.nil? || @address.nil? || @port.nil? || @user.nil? || @pass.nil?)
        end

        def send_message(dest, title, message)
          @log.info("send(#{dest}) -> #{title}: #{message}")
          
          Notifier.deliver_email(@sender, dest, title, message)
        end
        
        register self
      end
    end
  end
end
