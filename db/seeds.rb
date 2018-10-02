require_relative("../models/currency.rb")
require_relative("../models/merchant.rb")
require_relative("../models/tag.rb")
require_relative("../models/user.rb")
require_relative("../models/transaction.rb")
require("pry-byebug")

# Clear tables
Transaction.delete_all()
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

user2 = User.new({
  "first_name" => "Sarah",
  "last_name" => "Struthers",
  "email" => "sarah@gmail.com",
  "budget" => 50
  })

user2.save()

# Populate Transactions
transaction1 = Transaction.new({
  "user_id" => user1.id,
  "tag_id" => tag1.id,
  "merchant_id" => merchant1.id,
  "currency_id" => currency1.id,
  "amount" => 50.35,
  "trx_time" => '2018-10-01 15:00:00'
  })

transaction1.save()

transaction2 = Transaction.new({
  "user_id" => user1.id,
  "tag_id" => tag2.id,
  "merchant_id" => merchant2.id,
  "currency_id" => currency1.id,
  "amount" => 20,
  "trx_time" => '2018-09-30 16:30:00'
  })
transaction2.save()

transaction3 = Transaction.new({
  "user_id" => user2.id,
  "tag_id" => tag1.id,
  "merchant_id" => merchant1.id,
  "currency_id" => currency1.id,
  "amount" => 34,
  "trx_time" => '2018-10-01 19:30:00'
  })
transaction3.save()


binding.pry
nil
