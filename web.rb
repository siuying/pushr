#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'sinatra/base'
require 'datamapper'

require "#{File.expand_path(File.dirname(__FILE__))}/lib/pushr"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/data/pushr.db")
Sinatra::Pushr::Node.first rescue DataMapper.auto_migrate!

class Pushr < Sinatra::Default
  register Sinatra::Pushr::Base
  set :timeout, 20
  set :views,  'views'
  set :public, 'public'
  set :environment, :production
  set :adapter_config, {:email_address => ENV['MAIL_FROM']}

end