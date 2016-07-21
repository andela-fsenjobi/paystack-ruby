# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "paystack/version"

Gem::Specification.new do |spec|
  spec.name          = "paystack"
  spec.version       = Paystack::VERSION
  spec.authors       = ["Victor"]
  spec.email         = ["ikoro.victor@gmail.com"]

  spec.summary       = "PayStack.co gem for Ruby/Rails"
  spec.description   = "Client Library Gem for PayStack.co"
  spec.homepage      = "https://github.com/IkoroVictor/paystack-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dev dependencies
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 0"

  # Dependencies
  spec.add_dependency "rest-client", "~> 1.8"
  spec.add_dependency "json"
end
