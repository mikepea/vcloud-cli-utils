# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'vcloud/cli/utils/version'
Gem::Specification.new do |s|
  s.name        = 'vcloud-cli-utils'
  s.version     = Vcloud::CLI::Utils::VERSION
  s.authors     = ['Mike Pountney']
  s.email       = ['Mike.Pountney@gmail.com']
  s.summary     = 'Various simple CLI utilities to communicate with the vCloud Director API'
  s.description = 'Various simple CLI utilities to communicate with the vCloud Director API. Uses vcloud-core and fog.'
  s.homepage    = 'http://github.com/mikepea/vcloud-cli-utils'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) {|f| File.basename(f)}
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency 'fog', '>= 1.20.0'
  s.add_runtime_dependency 'methadone'
  s.add_runtime_dependency 'vcloud-core', '>= 0.15.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'rubocop', '~> 0.23.0'
  s.add_development_dependency 'simplecov', '~> 0.8.2'
  s.add_development_dependency 'gem_publisher', '1.2.0'
end
