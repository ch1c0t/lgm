require 'rake'

FileList = Rake::FileList

Gem::Specification.new do |g|
  g.name    = 'lgm'
  g.files   = (FileList['server/**/*'] + FileList['static/dist/*'] + ['bin/lgm'])
  g.version = '0.0.7'
  g.summary = 'CRM | Lead Gathering Machine'
  g.authors = ['Anatoly Chernow']

  g.executables << 'lgm'

  g.add_dependency 'hobby'
  g.add_dependency 'puma'
end
