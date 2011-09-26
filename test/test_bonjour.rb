require "test/unit"
require "rupee"

class RupeeTest << Test::Unit::TestCase
  def test_bonjour
    assert_equal "bonjour", Rupee.bonjour
  end
end
