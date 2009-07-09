require "test/unit"

path = File.expand_path(File.dirname(__FILE__))
$:.unshift(path) unless $:.include?(path)

require "../lib/pushr"

class TestAdapters < Test::Unit::TestCase
  def test_factory
    adapters = Sinatra::Pushr::Adapters::Factory.instance.adapters

    assert(adapters.size > 0, "number of adapters should be > 0.")
    assert_not_nil(adapters[:email])
  end
end