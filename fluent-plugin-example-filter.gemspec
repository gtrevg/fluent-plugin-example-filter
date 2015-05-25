# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'fluent-plugin-example-filter'
  s.version       = '0.1.0'
  s.authors       = ['gtrevg']
  s.email         = ['github@trevorgattis.com']
  s.description   = %q{Bootstrap file for writing and testing a fluent filter}
  s.summary       = s.description
  s.homepage      = 'https://github.com/gtrevg/fluent-plugin-example-filter'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'fluentd', '>= 0.12.0'

  s.add_development_dependency 'rake', '~> 0'
end
