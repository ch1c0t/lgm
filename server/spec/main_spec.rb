require_relative '../app'

require 'rspec/power_assert'
RSpec::PowerAssert.example_assertion_alias :assert
RSpec::PowerAssert.example_group_assertion_alias :assert

describe do
  before do
    @pid = fork do
      server = Puma::Server.new App.new
      server.add_unix_listener "/tmp/#{$$}.sock"
      server.run
      sleep
    end
  end

  it do
    expect(0).to be 0
  end
end
