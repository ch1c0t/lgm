require_relative 'version'
require_relative 'api'

require 'slim'

class LGM
  include Hobby

  def initialize assets_dir: "#{__dir__}/assets",
                 lgm_dir: "#{ENV['HOME']}/.lgm"
    @assets_dir = assets_dir
    @template = Slim::Template.new "#{__dir__}/template.slim"
    map '/api', API.new(db_dir: lgm_dir)
  end

  get do
    @template.render
  end

  get '/main.js' do
    IO.read "#{@assets_dir}/main.js"
  end
end
