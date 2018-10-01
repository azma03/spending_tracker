require_relative("../db/sql_runner")

class Currency
  attr_accessor :name, :short_name
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @short_name = options["short_name"]
  end

  def save()
    sql = "INSERT INTO currencies
    (
      name,
      short_name
    )
    VALUES
    (
      $1,
      $2
    )
    RETURNING *"
    values = [@name, @short_name]
    currency = SqlRunner.run(sql, values)
    @id = currency.first()["id"].to_i
  end

  def update()
    sql = "UPDATE currencies SET
    (
      name,
      short_name
    )
    =
    (
      £1,
      $2
    )
    WHERE id = $3"
    values = [@name, @short_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM currencies WHERE id =$1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM currencies"
    currencies = SqlRunner.run(sql)
    return currencies.map {|currency| Currency.new(currency)}
  end

  def self.find(id)
    sql = "SELECT * FROM currencies WHERE id = $1"
    values =[id]
    currency = SqlRunner.run(sql, values)
    return Currency.new(currency.first())
  end

  def self.delete_all()
    sql = "DELETE FROM currencies"
    SqlRunner.run(sql)
  end


end
