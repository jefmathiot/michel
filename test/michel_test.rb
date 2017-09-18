require "test_helper"

class MichelTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Michel::VERSION
  end
end
