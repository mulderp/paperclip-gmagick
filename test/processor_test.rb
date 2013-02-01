$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
require 'paperclip'
require "test/unit"

class ProcessorTest < Test::Unit::TestCase

  def test_make_calls_gmagick
    image = File.new "#{File.dirname(__FILE__)}/support/image.png"
    processor = Paperclip::GMagick.make image
    assert :ok, processor
  end

end
