require("minitest/autorun")
require("minitest/rg")
require_relative("../merchant.rb")

class TestMerchant < MiniTest::Test

  def setup
    @merchant1 = Merchant.new({
      "name" => "Tesco"
      })
  end

  def test_merchant_name()
    result = @merchant1.name
    assert_equal("Tesco", result)
  end

end
