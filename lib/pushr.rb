path = File.expand_path(File.dirname(__FILE__))
$:.unshift(path) unless $:.include?(path)
require 'rubygems'

require 'sinatra/pushr/node'
require 'sinatra/pushr/base'
require 'sinatra/pushr/adapters/factory'
require 'sinatra/pushr/adapters/base'

require 'smtp_tls'
require 'actionmailer'
require 'action_mailer_tls'
require 'sinatra/pushr/adapters/email_adapter'
require 'sinatra/pushr/adapters/growl_adapter'