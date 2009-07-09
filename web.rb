#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'sinatra/base'
require 'datamapper'

require "#{File.expand_path(File.dirname(__FILE__))}/lib/pushr"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/data/pushr.db")
Sinatra::Pushr::Node.first rescue DataMapper.auto_migrate!

Notifier.delivery_method = :smtp
Notifier.template_root = "#{File.dirname(__FILE__)}/views"
Notifier.smtp_settings = {
  :address  => ENV['MAIL_ADDRESS'],
  :port  => ENV['MAIL_PORT'],
  :user_name  => ENV['MAIL_USER'],
  :password  => ENV['MAIL_PASS'],
  :authentication => :plain,
  :tls => true
}

class Pushr < Sinatra::Default
  register Sinatra::Pushr::Base
  set :timeout, 20
  set :views,  'views'
  set :public, 'public'
  set :environment, :production
  set :adapter_config, {:email_address => ENV['MAIL_FROM']}

end