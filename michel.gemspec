# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'michel/version'

Gem::Specification.new do |spec|
  spec.name          = 'michel'
  spec.version       = Michel::VERSION
  spec.authors       = ['Jef Mathiot']
  spec.email         = ['jef@nonblocking.info']

  spec.summary       = 'Monitor dependencies in lockfiles'
  spec.description   = 'Inspect Gemfile.lock files and notify when updates ' \
                       'are available or vulnerable gems are detected.'
  spec.homepage      = 'https://github.com/servebox/michel'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_dependency 'bundler', '~> 2.2.5'
  spec.add_dependency 'thor', '~> 0.20', '>= 0.20.0'
  spec.add_dependency 'bundler-audit', '~> 0.6', '>= 0.6.0'
  spec.add_dependency 'actionmailer', '~> 5.1', '>= 5.1.4'
end
