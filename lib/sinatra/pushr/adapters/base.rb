module Sinatra
  module Pushr
    module Adapters
      class BaseAdpater
        def self.register(clazz)
          symbol = to_symbol_name(clazz)
          Factory.instance.register(symbol, clazz)
          
          puts symbol
          symbol
        end

        def send(title, message)
          raise "Implement Me"
        end

        protected
        def self.to_symbol_name(class_name)
          class_name.
              to_s.
              split("::").
              last.
              gsub(/(.)([A-Z])/, '\1_\2').
              downcase.
              gsub(/_adpater$/, '').
              to_sym
        end
      end
    end
  end
end
