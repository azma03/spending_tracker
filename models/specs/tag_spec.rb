require("minitest/autorun")
require("minitest/rg")
require_relative("../tag.rb")

class TestTag < MiniTest::Test

  def setup
    @tag1 = Tag.new({
      "name" => "Groceries"
      })
  end

  def test_tag_name()
    result = @tag1.name
    assert_equal("Groceries", result)
  end

end
