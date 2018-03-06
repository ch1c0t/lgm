require 'redis'

class LINKS
  def initialize dir
    @db = Redis.new path: "#{dir}/redis.sock"
  end

  def add link
    @db.lpush 'links_list', link
    @db.sadd 'links_set', link
  end

  def to_json
    to_a.to_json
  end

  def to_a
    @db.lrange 'links_list', 0, -1
  end

  def include? link
    @db.sismember 'links_set', link
  end

  def amount
    @db.scard 'links_set'
  end
end
