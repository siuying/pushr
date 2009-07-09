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
      end
    end
  end
end
