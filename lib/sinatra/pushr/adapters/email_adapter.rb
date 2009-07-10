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
Notifier.template_root = File.expand_path(File.dirname(__FILE__), "../../../../views")
Notifier.smtp_settings = {
  :address        => ENV['MAIL_ADDRESS'],
  :port           => ENV['MAIL_PORT'],
  :user_name      => ENV['MAIL_USER'],
  :password       => ENV['MAIL_PASS'],
  :authentication => :plain,
  :tls            => ENV['MAIL_TLS_ENABLED'] == "true"
}

module Sinatra
  module Pushr
    module Adapters
      class EmailAdpater < BaseAdpater
        def initialize
          @log = Logger.new($stdout)
        end

        def configure(options={})
          @log.info "configure email"
          @sender = options[:email_sender]
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
