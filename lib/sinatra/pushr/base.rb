require 'rubygems'
require 'sinatra/base'
require 'timeout'
$KCODE = 'UTF8'

gem 'activesupport', '>= 2.2.0'
require 'active_support'

module Sinatra
  module Pushr
    module Base
      class NotFound < StandardError; end

      def self.registered(app)
        app.helpers Helpers        
        app.set :timeout, 10

        app.before do
          @timeout = options.timeout
        end
        
        app.get '/' do
          erb :index
        end
        
        # Page to create a node
        app.get '/n' do
          
        end
        
        # Send input message
        app.get '/n/:name' do
          find_node(params[:name])
          erb :node
        end
        
        # Create a node
        app.put '/n/:name' do
          adapter = params[:adapter]
          dest    = params[:dest]
          name    = params[:name]

          node = Node.first(:name => name)
          halt(500, "node already exists") unless node.nil?  

          node = Node.new(:name => name, :destination => dest, :adapter => adapter)
          node.save
          "OK"
        end
        
        # Actually post message
        app.post '/n/:name' do
          find_node(params[:name])
          title   = params[:title]
          message = params[:message]

          Timeout::timeout(@timeout) do
            Sinatra::Pushr::Adapters.send_message(@node.adapter, @node.destination, title, message)
          end
          "OK"
        end

        # Delete Message
        app.delete '/n/:name' do
          find_node(params[:name])
          @node.destroy
        end
      end
      
      module Helpers
        def find_node(name)
          @node = Node.first(:name => params[:name])
          halt 404, "not found" if @node.nil?  

          @node
        end
        
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
