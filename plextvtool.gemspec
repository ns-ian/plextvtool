# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                  = 'plextvtool'
  s.version               = '0.1.0'
  s.required_ruby_version = '>= 2.5.0'
  s.summary               = 'Plex TV Tool'
  s.description           = 'A tool for renaming TV media files for Plex Media Server'
  s.authors               = ['Ian Wright']
  s.email                 = 'hello@ianwright.dev'
  s.homepage              = 'https://github.com/ns-ian/plextvtool'
  s.files                 = ['lib/plextvtoolservice.rb', 'lib/config.yml']
  s.license               = 'MIT'
  s.executables << 'plextvtool'
  s.add_runtime_dependency 'thor', '~> 1.0'
end
