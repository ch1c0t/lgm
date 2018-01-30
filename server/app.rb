require 'hobby'
require 'hobby/json'

require_relative 'link'
require_relative 'links'

class API
  include Hobby
  include JSON

  get '/links' do
    LINKS
  end

  post '/links' do
    link = Link.new json['link']

    if link.valid? && ( not LINKS.include? link )
      LINKS.add link
      link
    else
      response.status = 422
    end
  end

  get '/links/amount' do
    LINKS.amount
  end
end

class App
  include Hobby

  def initialize path
    @path = path
  end

  map '/api', API.new

  get do
    IO.read "#{@path}/index.html"
  end

  get '/:name.:ext' do
    IO.read "#{@path}/#{my[:name]}.#{my[:ext]}"
  end
end
