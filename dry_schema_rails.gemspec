require_relative 'lib/dry_schema_rails/version'

Gem::Specification.new do |s|
  s.name = "dry_schema_rails"
  s.version = DrySchemaRails::VERSION
  s.date = "2023-10-12"
  s.summary = "Simple DSL for reusing dry-schema in Rails."
  s.description = "Simple DSL for reusing dry-schema in Rails. "
  s.authors = ["David Rybolovlev"]
  s.email = "i@golifox.com"
  s.files = ["lib/**/*"]
  s.homepage = "http://github.com/golifox/dry_schema_rails"
  s.license = "MIT"
  s.required_ruby_version = ">= 2.5.0"

  s.add_dependency "dry-schema", "~> 1.5"
  s.add_dependency "activesupport", "~> 6.1"

  s.add_development_dependency "rspec", "~> 3.10"
end
