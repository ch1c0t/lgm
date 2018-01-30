require 'redis'
require_relative 'constants'
R = Redis.new path: "#{LGM_DIR}/redis.sock"

module LINKS
  extend self

  def add link
    R.lpush 'links_list', link
    R.sadd 'links_set', link
  end

  def to_json
    to_a.to_json
  end

  def to_a
    R.lrange 'links_list', 0, -1
  end

  def include? link
    R.sismember 'links_set', link
  end

  def amount
    R.scard 'links_set'
  end
end
