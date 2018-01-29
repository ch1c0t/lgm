require 'hobby'
require 'hobby/json'

class API
  include Hobby
  include JSON

  get '/links' do
    ['/main.js', '/another.html']
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
