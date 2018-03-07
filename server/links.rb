require 'redis'

class LGM
  class LINKS
    def initialize dir
      @db = Redis.new path: "#{dir}/redis.sock"
    end

    def add link
      @db.lpush 'links_list', link
      @db.sadd 'links_set', link
    end

    def between from = 0, to = -1
      @db.lrange 'links_list', from, to
    end

    def include? link
      @db.sismember 'links_set', link
    end

    def amount
      @db.scard 'links_set'
    end
  end
end
