# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dry_schema_rails/version"

Gem::Specification.new do |spec|
  spec.name = "dry_schema_rails"
  spec.version = DrySchemaRails::VERSION
  spec.date = "2023-10-12"
  spec.summary = "Simple DSL for reusing dry-schema in Rails."
  spec.description = "Simple DSL for reusing dry-schema in Rails."
  spec.authors = ["David Rybolovlev"]
  spec.email = "i@golifox.com"
  spec.homepage = "http://github.com/golifox/dry_schema_rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.files         = Dir["lib/**/*.rb"] + ["README.md", "LICENSE", "CHANGELOG.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-schema", "~> 1.5"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "bundler", "~> 2.0"
end
