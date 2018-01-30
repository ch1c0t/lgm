require 'rake'

FileList = Rack::FileList

Gem::Specification.new do |g|
  g.name    = 'lgm'
  g.files   = (FileList['server/**/*'] + FileList['static/dist/*'] + ['bin/lgm'])
  g.version = '0.0.0'
  g.summary = 'CRM | Lead Gathering Machine'
  g.authors = ['Anatoly Chernow']

  g.executables << 'lgm'
end
