require_relative("../db/sql_runner")

class CurrencyRate
  attr_accessor :source_currency_id, :destination_currency_id, :rate, :rate_date
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @source_currency_id = options["source_currency_id"].to_i
    @destination_currency_id = options["destination_currency_id"].to_i
    @rate = options["rate"].to_f
    @rate_date = options["rate_date"]
  end

  def save()
    sql = "INSERT INTO currency_rates
    (
      source_currency_id,
      destination_currency_id,
      rate,
      rate_date
    )
    VALUES
    (
      $1,
      $2,
      $3,
      $4
    )
    RETURNING *"
    values = [@source_currency_id, @destination_currency_id, @rate, @rate_date]
    currency_rate = SqlRunner.run(sql, values)
    @id = currency_rate.first()["id"].to_i
  end

  def update()
    sql = "UPDATE currency_rates SET
    (
      source_currency_id,
      destination_currency_id,
      rate,
      rate_date
    )
    =
    (
      $1,
      $2,
      $3,
      $4
    )
    WHERE id = $5"
    values = [@source_currency_id, @destination_currency_id, @rate, @rate_date, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM currency_rates WHERE id =$1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def get_source_currency()
    sql = "SELECT * FROM currencies WHERE id = $1"
    values =[@source_currency_id]
    currency = SqlRunner.run(sql, values)
    # binding.pry
    return Currency.new(currency.first())
  end

  def get_destination_currency()
    sql = "SELECT * FROM currencies WHERE id = $1"
    values =[@destination_currency_id]
    currency = SqlRunner.run(sql, values)
    # binding.pry
    return Currency.new(currency.first())
  end

  def self.all()
    sql = "SELECT * FROM currency_rates ORDER BY id ASC"
    currency_rates = SqlRunner.run(sql)
    return currency_rates.map {|currency_rate| CurrencyRate.new(currency_rate)}
  end

  def self.find(id)
    sql = "SELECT * FROM currency_rates WHERE id = $1"
    values =[id]
    currency_rate = SqlRunner.run(sql, values)
    return CurrencyRate.new(currency_rate.first())
  end

  def self.delete_all()
    sql = "DELETE FROM currency_rates"
    SqlRunner.run(sql)
  end


end
