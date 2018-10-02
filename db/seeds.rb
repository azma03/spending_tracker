require_relative("../models/currency.rb")
require_relative("../models/merchant.rb")
require_relative("../models/tag.rb")
require_relative("../models/user.rb")
require_relative("../models/transaction.rb")
require_relative("../models/currency_rate.rb")
require("pry-byebug")

# Clear tables
Transaction.delete_all()
CurrencyRate.delete_all()
User.delete_all()
Tag.delete_all()
Merchant.delete_all()
Currency.delete_all()

# Populate Currencies
currency1 = Currency.new({
  "name" => "Pound Sterling",
  "short_name" => "GBP"
  })

currency1.save()

currency2 = Currency.new({
  "name" => "US Dollar",
  "short_name" => "USD"
  })

currency2.save()

currency3 = Currency.new({
  "name" => "Euros",
  "short_name" => "EUR"
  })

currency3.save()

# Populate Merchants
merchant1 = Merchant.new({
  "name" => "Tesco"
  })

merchant1.save()

merchant2 = Merchant.new({
  "name" => "Amazon"
  })

merchant2.save()

merchant3 = Merchant.new({
  "name" => "ScotRail"
  })

merchant3.save()

# # Populate Tags
tag1 = Tag.new({
  "name" => "Groceries"
  })

tag1.save()


tag2 = Tag.new({
  "name" => "Entertainment"
  })

tag2.save()


tag3 = Tag.new({
  "name" => "Transport"
  })

tag3.save()

# Populate Uesrs
user1 = User.new({
  "first_name" => "Asma",
  "last_name" => "Malik",
  "email" => "asma@gmail.com",
  "budget" => 100
  })

user1.save()

# user2 = User.new({
#   "first_name" => "Sarah",
#   "last_name" => "Struthers",
#   "email" => "sarah@gmail.com",
#   "budget" => 50
#   })
#
# user2.save()

# Populate Transactions
transaction1 = Transaction.new({
  "user_id" => user1.id,
  "tag_id" => tag1.id,
  "merchant_id" => merchant1.id,
  "currency_id" => currency1.id,
  "amount" => 50.35,
  "trx_time" => '2018-10-01'
  })

transaction1.save()

transaction2 = Transaction.new({
  "user_id" => user1.id,
  "tag_id" => tag2.id,
  "merchant_id" => merchant2.id,
  "currency_id" => currency1.id,
  "amount" => 20,
  "trx_time" => '2018-09-30'
  })
transaction2.save()

transaction3 = Transaction.new({
  "user_id" => user1.id,
  "tag_id" => tag1.id,
  "merchant_id" => merchant1.id,
  "currency_id" => currency1.id,
  "amount" => 34,
  "trx_time" => '2018-10-01'
  })
transaction3.save()

currency_rate1= CurrencyRate.new({
  "source_currency_id" => currency1.id,
  "destination_currency_id" => currency1.id,
  "rate" => 1,
  "rate_date" => '2018-09-30'
  })
currency_rate1.save()

currency_rate2= CurrencyRate.new({
  "source_currency_id" => currency1.id,
  "destination_currency_id" => currency1.id,
  "rate" => 1,
  "rate_date" => '2018-10-01'
  })
currency_rate2.save()

currency_rate3= CurrencyRate.new({
  "source_currency_id" => currency1.id,
  "destination_currency_id" => currency1.id,
  "rate" => 1,
  "rate_date" => '2018-10-02'
  })
currency_rate3.save()

currency_rate4= CurrencyRate.new({
  "source_currency_id" => currency2.id,
  "destination_currency_id" => currency1.id,
  "rate" => 0.77,
  "rate_date" => '2018-09-30'
  })
currency_rate4.save()

currency_rate5= CurrencyRate.new({
  "source_currency_id" => currency2.id,
  "destination_currency_id" => currency1.id,
  "rate" => 0.77,
  "rate_date" => '2018-10-01'
  })
currency_rate5.save()

currency_rate6= CurrencyRate.new({
  "source_currency_id" => currency2.id,
  "destination_currency_id" => currency1.id,
  "rate" => 0.77,
  "rate_date" => '2018-10-02'
  })
currency_rate6.save()

currency_rate7= CurrencyRate.new({
  "source_currency_id" => currency3.id,
  "destination_currency_id" => currency1.id,
  "rate" => 0.89,
  "rate_date" => '2018-09-30'
  })
currency_rate7.save()

currency_rate8= CurrencyRate.new({
  "source_currency_id" => currency3.id,
  "destination_currency_id" => currency1.id,
  "rate" => 0.89,
  "rate_date" => '2018-10-01'
  })
currency_rate8.save()

currency_rate9= CurrencyRate.new({
  "source_currency_id" => currency3.id,
  "destination_currency_id" => currency1.id,
  "rate" => 0.89,
  "rate_date" => '2018-10-02'
  })
currency_rate9.save()

binding.pry
nil
