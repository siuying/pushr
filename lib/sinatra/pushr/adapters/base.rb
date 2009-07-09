module Sinatra
  module Pushr
    module Adapters
      class BaseAdpater
        def self.register(clazz)
          symbol = to_symbol_name(clazz)
          Factory.instance.register(symbol, clazz)
          symbol
        end

        def send_message(dest, title, message)
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

      def send_message(adapter, dest, title, message)
        adapter = Factory.instance.adapters[adapter.to_sym]
        raise ArgumentError.new("adapter not found") if adapter.nil?

        adapter.send_message(dest, title, message)
      end
      module_function :send_message
    end
  end
end
