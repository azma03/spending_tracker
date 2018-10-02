require("minitest/autorun")
require("minitest/rg")
require("pry-byebug")
require_relative("../currency.rb")
require_relative("../currency_rate.rb")

class TestCurrencyRate < MiniTest::Test

  def setup
    @currency1 = Currency.new({
      "name" => "Pound Sterling",
      "short_name" => "GBP"
      })

    @currency2 = Currency.new({
      "name" => "US Dollar",
      "short_name" => "USD"
      })

    @currency_rate1 = CurrencyRate.new({
      "source_currency_id" => @currency2.id,
      "destination_currency_id" => @currency1.id,
      "rate" => 0.77,
      "rate_date" => '2018-10-01'
      })
  end

  # def test_source_currency_id()
  #   result = @currency_rate1.source_currency_id
  #   binding.pry
  #   assert_equal(@currency2.id, result)
  # end
  #
  # def test_destination_currency_id()
  #   result = @currency_rate1.destination_currency_id
  #   assert_equal(@currency1.id, result)
  # end

  def test_rate()
    result = @currency_rate1.rate
    assert_equal(0.77, result)
  end

  def test_rate_date()
    result = @currency_rate1.rate_date
    assert_equal('2018-10-01', result)
  end

end
