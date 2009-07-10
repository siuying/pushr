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
          Notifier.smtp_settings = {
            :address        => options[:email_address] || ENV['MAIL_ADDRESS'],
            :port           => options[:email_port] || ENV['MAIL_PORT'],
            :user_name      => options[:email_user] || ENV['MAIL_USER'],
            :password       => options[:email_pass] || ENV['MAIL_PASS'],
            :authentication => :plain,
            :tls            => options[:email_address] || ENV['MAIL_TLS_ENABLED'] == "true"
          }
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
