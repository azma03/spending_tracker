require("minitest/autorun")
require("minitest/rg")
require_relative("../transaction.rb")
require_relative("../user.rb")
require_relative("../merchant.rb")
require_relative("../tag.rb")
require_relative("../currency.rb")

class TestTransaction < MiniTest::Test

  def setup
    @currency1 = Currency.new({
      "name" => "Pound Sterling",
      "short_name" => "GBP"
      })

    @merchant1 = Merchant.new({
      "name" => "Tesco"
      })

    @tag1 = Tag.new({
      "name" => "Groceries"
      })

    @user1 = User.new({
      "first_name" => "Asma",
      "last_name" => "Malik",
      "email" => "asma@gmail.com",
      "budget" => 100
      })

    @transaction1 = Transaction.new({
      "user_id" => @user1.id,
      "tag_id" => @tag1.id,
      "merchant_id" => @merchant1.id,
      "currency_id" => @currency1.id,
      "amount" => 50.35,
      "trx_time" => '2018-10-01 15:00:00'
      })
  end

  def test_user_id()
    result = @transaction1.user_id
    assert_equal(@user1.id, result)
  end

  def test_merchant_id()
    result = @transaction1.merchant_id
    assert_equal(@merchant1.id, result)
  end

  def test_tag_id()
    result = @transaction1.tag_id
    assert_equal(@tag1.id, result)
  end

  def test_currency_id()
    result = @transaction1.currency_id
    assert_equal(@currency1.id, result)
  end

  def test_amount()
    result = @transaction1.amount
    assert_equal(50.35, result)
  end

  def test_trx_time()
    result = @transaction1.trx_time
    assert_equal('2018-10-01 15:00:00', result)
  end

end
