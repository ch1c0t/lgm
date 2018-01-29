require 'hobby'
require 'hobby/json'

require_relative 'link'
LINKS = [Link.new('/main.js'), Link.new('/another.html')]

class API
  include Hobby
  include JSON

  get '/links' do
    LINKS
  end

  post '/links' do
    link = Link.new json['link']

    if link.valid?
      LINKS << link
      link
    end
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
