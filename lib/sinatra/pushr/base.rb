require 'rubygems'
require 'sinatra/base'
$KCODE = 'UTF8'

gem 'activesupport', '>= 2.2.0'
require 'active_support'

module Sinatra
  module Pushr
    module Base
      def self.registered(app)
        app.helpers Helpers        
        
        app.get '/' do
          erb :index
        end
        
        # Page to create a node
        app.get '/n' do
        end
        
        # Send input message
        app.get '/n/:name' do
        end

        # Actually post message
        app.post '/n/:name' do
        end

        # Delete Message
        app.delete '/n/:name' do
        end        
      end
      
      module Helpers
        def h(text)
          Rack::Utils.escape_html(text) 
        end
        def u(text)
          Rack::Utils.escape(text)                      
        end
      end
    end
  end

  register Pushr::Base
end
