require 'fileutils'

require 'hobby'
require 'hobby/json'

require_relative 'link'
require_relative 'links'

class API
  include Hobby
  include JSON

  def initialize db_dir:
    initialize_data_store_at db_dir
  end

  def initialize_data_store_at dir
    FileUtils.mkdir_p dir
    redis_pid = spawn "redis-server --unixsocket #{dir}/redis.sock --port 0 --dir #{dir} --appendonly yes > /dev/null"
    at_exit { `kill #{redis_pid}` }
    @links = LINKS.new dir
  end

  get '/links' do
    @links
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

module LGM
  Version = '0.0.12'
end

class App
  include Hobby

  def initialize assets_dir: "#{__dir__}/assets",
                 lgm_dir: "#{ENV['HOME']}/.lgm"
    @assets_dir = assets_dir
    map '/api', API.new(db_dir: lgm_dir)
  end

  get do
    IO.read "#{@assets_dir}/index.html"
  end

  get '/:name.:ext' do
    IO.read "#{@assets_dir}/#{my[:name]}.#{my[:ext]}"
  end
end
