require_relative("../db/sql_runner")
require("pry-byebug")

class Transaction
  attr_accessor :user_id, :tag_id, :merchant_id, :currency_id, :amount, :trx_time
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @user_id = options["user_id"]
    @tag_id = options["tag_id"] if options["tag_id"]
    @merchant_id = options["merchant_id"] if options["merchant_id"]
    @currency_id = options["currency_id"] if options["currency_id"]
    @amount = options["amount"].to_f if options["amount"]
    @trx_time = options["trx_time"]
  end

  def save()
    sql = "INSERT INTO transactions
    (
      user_id,
      tag_id,
      merchant_id,
      currency_id,
      amount,
      trx_time
    )
    VALUES
    (
      $1,
      $2,
      $3,
      $4,
      $5,
      $6
    )
    RETURNING *"
    values = [@user_id, @tag_id, @merchant_id, @currency_id, @amount, @trx_time]
    transaction = SqlRunner.run(sql, values)
    @id = transaction.first()["id"].to_i
  end

  def update()
    sql = "UPDATE transactions SET
    (
      user_id,
      tag_id,
      merchant_id,
      currency_id,
      amount,
      trx_time
    )
    =
    (
      $1,
      $2,
      $3,
      $4,
      $5,
      $6
    )
    WHERE id = $7"
    values = [@user_id, @tag_id, @merchant_id, @currency_id, @amount, @trx_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id =$1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def get_tag()
    sql = "SELECT * FROM tags WHERE id = $1"
    values =[@tag_id]
    tag = SqlRunner.run(sql, values)
    # binding.pry
    return Tag.new(tag.first())
  end

  def get_merchant()
    sql = "SELECT * FROM merchants WHERE id = $1"
    values =[@merchant_id]
    merchant = SqlRunner.run(sql, values)
    return Merchant.new(merchant.first())
  end

  def get_currency()
    sql = "SELECT * FROM currencies WHERE id = $1"
    values =[@currency_id]
    currency = SqlRunner.run(sql, values)
    return Currency.new(currency.first())
  end

  def self.all()
    sql = "SELECT * FROM transactions ORDER BY id"
    transactions = SqlRunner.run(sql)
    return transactions.map {|transaction| Transaction.new(transaction)}
  end

  def self.all_by_time_asc()
    sql = "SELECT * FROM transactions ORDER BY trx_time ASC"
    transactions = SqlRunner.run(sql)
    return transactions.map {|transaction| Transaction.new(transaction)}
  end

  def self.all_by_time_desc()
    sql = "SELECT * FROM transactions ORDER BY trx_time DESC"
    transactions = SqlRunner.run(sql)
    return transactions.map {|transaction| Transaction.new(transaction)}
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values =[id]
    transaction = SqlRunner.run(sql, values)
    return Transaction.new(transaction.first())
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  # def self.get_total_spendings()
  #   sql = "SELECT sum(amount) FROM transactions"
  #   result = SqlRunner.run(sql)
  #   total_spendings = result[0]["sum"].to_f
  #   return total_spendings
  # end

  def self.get_total_spendings()
    sql = "SELECT sum(t.amount * ct.rate)
      FROM transactions t
      INNER JOIN currency_rates ct
      ON ct.source_currency_id = t.currency_id
      WHERE ct.rate_date = DATE(t.trx_time)"
    result = SqlRunner.run(sql)
    total_spendings = result[0]["sum"].to_f
    return total_spendings
  end

  def self.find_all_by_tag(tagid)
    sql = "SELECT * FROM transactions WHERE tag_id = $1"
    values = [tagid]
    transactions = SqlRunner.run(sql, values)
    return transactions.map {|transaction| Transaction.new(transaction)}
  end

  # def self.get_total_spendings_by_tag(tagid)
  #   sql = "SELECT sum(amount) FROM transactions WHERE tag_id = $1"
  #   values = [tagid]
  #   result = SqlRunner.run(sql, values)
  #   total_spendings = result[0]["sum"].to_f
  #   return total_spendings
  # end

  def self.get_total_spendings_by_tag(tagid)
    sql = "SELECT sum(t.amount * ct.rate)
      FROM transactions t
      INNER JOIN currency_rates ct
      ON ct.source_currency_id = t.currency_id
      WHERE ct.rate_date = DATE(t.trx_time)
      AND t.tag_id = $1"
    values = [tagid]
    result = SqlRunner.run(sql, values)
    total_spendings = result[0]["sum"].to_f
    return total_spendings
  end

  def self.find_all_by_date(month, year)
    sql = "SELECT * FROM transactions
      WHERE DATE_PART('month', trx_time) = $1
      AND DATE_PART('year', trx_time) = $2"
    values = [month, year]
    transactions = SqlRunner.run(sql, values)
    return transactions.map {|transaction| Transaction.new(transaction)}
  end

  # def self.get_total_spendings_by_date(month, year)
  #   sql = "SELECT sum(amount) FROM transactions
  #   WHERE DATE_PART('month', trx_time) = $1
  #   AND DATE_PART('year', trx_time) = $2"
  #   values = [month, year]
  #   result = SqlRunner.run(sql, values)
  #   total_spendings = result[0]["sum"].to_f
  #   return total_spendings
  # end

  def self.get_total_spendings_by_date(month, year)
    sql = "SELECT sum(t.amount * ct.rate)
      FROM transactions t
      INNER JOIN currency_rates ct
      ON ct.source_currency_id = t.currency_id
      WHERE ct.rate_date = DATE(t.trx_time)
      AND DATE_PART('month', t.trx_time) = $1
      AND DATE_PART('year', t.trx_time) = $2"
    values = [month, year]
    result = SqlRunner.run(sql, values)
    total_spendings = result[0]["sum"].to_f
    return total_spendings
  end

  # def self.get_total_savings(user)
  #   sql = "SELECT sum(amount) FROM transactions
  #   WHERE DATE_PART('month', trx_time) = DATE_PART('month', CURRENT_DATE)"
  #   spendings = SqlRunner.run(sql)
  #   total_savings = (user.budget.to_f - spendings[0]["sum"].to_f).round(2)
  #   return total_savings
  # end

  def self.get_total_savings(user)
    sql = "SELECT sum(t.amount * ct.rate)
      FROM transactions t
      INNER JOIN currency_rates ct
      ON ct.source_currency_id = t.currency_id
      WHERE ct.rate_date = DATE(t.trx_time)
      AND DATE_PART('month', t.trx_time) = DATE_PART('month', CURRENT_DATE)"
    spendings = SqlRunner.run(sql)
    total_savings = (user.budget.to_f - spendings[0]["sum"].to_f).round(2)
    return total_savings
  end

end
