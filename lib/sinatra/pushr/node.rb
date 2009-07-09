module Sinatra
  module Pushr
    class Node
      include DataMapper::Resource
      property  :id,          Serial
      property  :name,        String, :length => 256
      property  :adapter,     String, :length => 64
      property  :destination, String, :length => 256
    end
  end
end
