module Sinatra
  module Pushr
    module Adapters
      class BaseAdapter
        attr_accessor :options

        def self.register(clazz)
          symbol = to_symbol_name(clazz)
          Factory.instance.register(symbol, clazz)
          symbol
        end

        def send_message(dest, title, message)
          raise "Implement Me"
        end
        
        def configure(options)
        end
        
        protected
        def self.to_symbol_name(class_name)
          class_name.
              to_s.
              split("::").
              last.
              gsub(/(.)([A-Z])/, '\1_\2').
              downcase.
              gsub(/_adapter$/, '').
              to_sym
        end
      end
      
      def configure(options)
        Factory.instance.configure(options)
      end
      module_function :configure
      
      def send_message(adapter_name, dest, title, message)
        adapter = Factory.instance.adapters[adapter_name.to_sym]
        raise ArgumentError.new("adapter not found: #{adapter_name}") if adapter.nil?
        adapter.send_message(dest, title, message)
      end
      module_function :send_message
    end
  end
end
