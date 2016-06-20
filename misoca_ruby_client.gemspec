# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'misoca_ruby_client/version'

Gem::Specification.new do |spec|
  spec.name          = "misoca_ruby_client"
  spec.version       = MisocaRubyClient::VERSION
  spec.authors       = ["Kevin Tsai"]
  spec.email         = ["hokichaio@hotmail.com"]

  spec.summary       = %q{A client lib for Misoca.}
  spec.description   = %q{This client lib allow you to save/inject access token.}
  spec.homepage      = "https://github.com/hokichaio/misoca-ruby-client."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth2", "~> 1.1.0"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
