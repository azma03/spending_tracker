require_relative("../db/sql_runner")

class Tag
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO tags
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@name]
    tag = SqlRunner.run(sql, values)
    @id = tag.first()["id"].to_i
  end

  def update()
    sql = "UPDATE tags SET
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
    sql = "DELETE FROM tags WHERE id =$1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tags"
    tags = SqlRunner.run(sql)
    return tags.map {|tag| Tag.new(tag)}
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values =[id]
    tag = SqlRunner.run(sql, values)
    return Tag.new(tag.first())
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end


end
