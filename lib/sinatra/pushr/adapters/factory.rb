require 'singleton'

module Sinatra
  module Pushr
    module Adapters
      class Factory
        include Singleton
        attr_reader :adapters

        def initialize
          @adapters = {}
        end

        def register(name, adapter)
          @adapters[name] = adapter.new
        end
        
        def configure(options)
          options.adapters.split(",").each do |name|
            require "#{File.dirname(__FILE__)}//#{name}_adapter"
          end

          @adapters.keys.each do |k| 
            @adapters[k].configure(options.adapter_config)
          end
        end
      end
    end
  end
end
