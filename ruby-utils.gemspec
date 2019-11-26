# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |spec|
  spec.name = 'ruby-utils'
  spec.summary = 'Utility classes'
  spec.version = '0.0.1'

  spec.authors = ['Hosam Aly']
  spec.email = ['hosamaly6@gmail.com']

  spec.files = Dir['lib/**/*']
  spec.test_files = Dir['spec/**/*']

  spec.add_development_dependency 'faker', '~> 2.7'
  spec.add_development_dependency 'rspec', '~> 3.9'
end
