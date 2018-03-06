require_relative 'helper'
require_relative '../api'

require 'excon'
require 'puma'

describe do
  before do
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
  end

  it do
    response = @excon.get path: '/links/amount'
    assert { response.body == '0' }
  end

  after do
    `kill #{@pid}`
  end
end
