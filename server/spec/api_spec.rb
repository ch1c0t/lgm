require_relative 'helper'
require_relative '../api'

require 'excon'
require 'puma'

describe do
  before :all do
    test_dir = "/tmp/lgm_test/#{$$}"
    socket = "#{test_dir}/http.sock"
    @pid = fork do
      server = Puma::Server.new LGM::API.new db_dir: test_dir
      server.add_unix_listener socket
      server.run
      sleep
    end
    sleep 1
    @excon = Excon.new 'unix:///', socket: socket
    seed_links
  end

  def seed_links
    letters = ('a'..'z').to_a
    @links = 20.times.map { "https://#{letters.sample(16).join}.org" }.uniq
    assert { @links.size == 20 }

    @links.each do |link|
      @excon.post path: '/links',
        body: { link: link }.to_json
    end
  end

  it "returns links' amount" do
    response = @excon.get path: '/links/amount'
    assert { response.body == '20' }
  end

  it 'returns all the links' do
    response = @excon.get path: '/links'
    links = JSON.parse response.body
    assert { links == @links.reverse }
  end

  it 'returns a subset of the links' do
    response = @excon.get path: '/links',
      query: { from: 2, to: 8 }
    actual_links = JSON.parse response.body
    expected_links = @links.reverse[2..8]

    assert { actual_links == expected_links }
  end

  after :all do
    `kill #{@pid}`
  end
end
