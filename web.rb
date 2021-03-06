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
  set :environment, ENV['RACK_ENV'].to_sym
  set :adapters,    ENV['ADAPTERS'] || "email,growl,twitter"
  set :adapter_config, {}

end