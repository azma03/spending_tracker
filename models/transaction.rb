require_relative("../db/sql_runner")

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

  def self.all()
    sql = "SELECT * FROM transactions"
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


end
