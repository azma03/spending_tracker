require_relative("../db/sql_runner")

class User
  attr_accessor :first_name, :last_name, :email, :budget
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @email = options["email"] if options["email"]
    @budget = options["budget"].to_f if options["budget"]
  end

  def save()
    sql = "INSERT INTO users
    (
      first_name,
      last_name,
      email,
      budget
    )
    VALUES
    (
      $1,
      $2,
      $3,
      $4
    )
    RETURNING *"
    values = [@first_name, @last_name, @email, @budget]
    user = SqlRunner.run(sql, values)
    @id = user.first()["id"].to_i
  end

  def update()
    sql = "UPDATE users SET
    (
      first_name,
      last_name,
      email,
      budget
    )
    =
    (
      $1,
      $2,
      $3,
      $4
    )
    WHERE id = $5"
    values = [@first_name, @last_name, @email, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM users WHERE id =$1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM users"
    users = SqlRunner.run(sql)
    return users.map {|user| User.new(user)}
  end

  def self.find(id)
    sql = "SELECT * FROM users WHERE id = $1"
    values =[id]
    user = SqlRunner.run(sql, values)
    return User.new(user.first())
  end

  def self.delete_all()
    sql = "DELETE FROM users"
    SqlRunner.run(sql)
  end


end
