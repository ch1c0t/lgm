require 'rake'
require_relative 'server/version'

FileList = Rake::FileList

Gem::Specification.new do |g|
  g.name    = 'lgm'
  g.files   = (FileList['server/**/*'] + FileList['static/dist/*'] + ['bin/lgm'])
  g.version = LGM::VERSION
  g.summary = 'CRM | Lead Gathering Machine'
  g.authors = ['Anatoly Chernow']

  g.executables << 'lgm'

  g.add_dependency 'hobby'
  g.add_dependency 'hobby-json'
  g.add_dependency 'redis'
  g.add_dependency 'puma'
  g.add_dependency 'suppress_output'
end
