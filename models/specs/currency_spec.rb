require("minitest/autorun")
require("minitest/rg")
require_relative("../currency.rb")

class TestCurrency < MiniTest::Test

  def setup
    @currency1 = Currency.new({
      "name" => "Pound Sterling",
      "short_name" => "GBP"
      })
  end

  def test_currency_name()
    result = @currency1.name
    assert_equal("Pound Sterling", result)
  end

  def test_currency_short_name()
    result = @currency1.short_name
    assert_equal("GBP", result)
  end

end
