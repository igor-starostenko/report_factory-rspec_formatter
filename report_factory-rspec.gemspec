# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'report_factory/rspec/version'

Gem::Specification.new do |spec|
  spec.name          = 'report_factory-rspec'
  spec.version       = ReportFactory::Rspec::VERSION
  spec.authors       = ['Igor Starostenko']
  spec.email         = ['contactigorstar@gmail.com']

  spec.summary       = "report_factory-rspec_#{ReportFactory::Rspec::VERSION}"
  spec.description   = 'RSpec adapter for report_factory'
  spec.homepage      = 'https://github.com/igor-starostenko/report_factory-rspec'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.require_paths = ['lib']

  spec.add_dependency 'rspec', '~> 3.5'

  spec.add_development_dependency 'rubocop', '~> 0.75.1'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'webmock', '~> 3.5'
end
