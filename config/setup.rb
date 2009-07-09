require "#{File.expand_path(File.dirname(__FILE__))}/../lib/pushr"
require 'rubygems'
require 'datamapper'

include Sinatra::Pushr

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/data/pushr.db")
Node.first? rescue DataMapper.auto_migrate!