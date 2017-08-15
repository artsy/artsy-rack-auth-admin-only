# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'artsy_auth/version'

Gem::Specification.new do |spec|
  spec.name          = 'artsy-rack-auth-admin-only'
  spec.version       = ArtsyAuth::VERSION
  spec.authors       = ['Orta Therox', 'Will Goldstein']
  spec.email         = ['orta.therox@gmail.com', 'williamrgoldstein@gmail.com']

  spec.summary       = 'A simple gem for adding Rack based admin-only Oauth-credentials to Artsy apps.'
  spec.description   = 'A simple gem for adding Rack based admin-only Oauth-credentials to Artsy apps.'
  spec.homepage      = 'https://github.com/artsy/artsy-rack-auth-admin-only'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rack'
  spec.add_runtime_dependency 'jwt'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
