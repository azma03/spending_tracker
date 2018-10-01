require_relative("../db/sql_runner")

class Merchant
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO merchants
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@name]
    merchant = SqlRunner.run(sql, values)
    @id = merchant.first()["id"].to_i
  end

  def update()
    sql = "UPDATE merchants SET
    (
      name
    )
    =
    (
      £1
    )
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM merchants WHERE id =$1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    return merchants.map {|merchant| merchant.new(merchant)}
  end

  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values =[id]
    merchant = SqlRunner.run(sql, values)
    return merchant.new(merchant.first())
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end


end
