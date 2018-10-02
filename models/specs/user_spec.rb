require("minitest/autorun")
require("minitest/rg")
require_relative("../user.rb")

class TestUser < MiniTest::Test

  def setup
    @user1 = User.new({
      "first_name" => "Asma",
      "last_name" => "Malik",
      "email" => "asma@gmail.com",
      "budget" => 100
      })
  end

  def test_first_name()
    result = @user1.first_name
    assert_equal("Asma", result)
  end

  def test_last_name()
    result = @user1.last_name
    assert_equal("Malik", result)
  end

  def test_email()
    result = @user1.email
    assert_equal("asma@gmail.com", result)
  end

  def test_budget()
    result = @user1.budget
    assert_equal(100, result)
  end

end
