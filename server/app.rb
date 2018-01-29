require 'hobby'

class App
  include Hobby

  def initialize path
    @path = path
  end

  get do
    IO.read "#{@path}/index.html"
  end

  get '/:name.:ext' do
    IO.read "#{@path}/#{my[:name]}.#{my[:ext]}"
  end
end
