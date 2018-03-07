require 'fileutils'

require 'suppress_output'
require 'hobby'
require 'hobby/json'

require_relative 'link'
require_relative 'links'

class LGM
  class API
    include Hobby
    include JSON

    def initialize db_dir:
      initialize_data_store_at db_dir
    end

    def initialize_data_store_at dir
      FileUtils.mkdir_p dir
      redis_pid = suppress_output do
        spawn "redis-server --unixsocket #{dir}/redis.sock --port 0 --dir #{dir} --appendonly yes"
      end; at_exit { `kill #{redis_pid}` }
      @links = LINKS.new dir
    end

    get '/links' do
      from, to = request.params.values_at 'from', 'to'
      from ||= 0
      to ||= -1
      @links.between from, to
    end

    post '/links' do
      link = Link.new json['link']

      if link.valid? && ( not @links.include? link )
        @links.add link
        link
      else
        response.status = 422
      end
    end

    get '/links/amount' do
      @links.amount
    end
  end
end
