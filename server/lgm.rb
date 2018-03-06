require_relative 'version'
require_relative 'api'

class LGM
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
