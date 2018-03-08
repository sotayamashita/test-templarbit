$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'templarbit/version'

Gem::Specification.new do |s|
  s.name        = 'templarbit'
  s.version     = Templarbit::VERSION
  s.author      = 'Templarbit Inc.'
  s.email       = 'hello@templarbit.com'
  s.homepage    = 'https://github.com/templarbit/templarbit-ruby'
  s.summary     = 'Templarbit protects applications.'
  s.description = 'Templarbit protects applications from XSS attacks and other malicious activity.'
  s.license     = 'GPL-3.0'

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
