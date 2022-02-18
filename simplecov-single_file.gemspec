# frozen_string_literal: true

require_relative 'lib/simplecov/single_file/version'

Gem::Specification.new do |spec|
  spec.name = 'simplecov-single_file'
  spec.version = ::SimpleCov::SingleFile::VERSION
  spec.authors = ['Taras Shpachenko']
  spec.email = ['taras.shpachenko@gmail.com']

  spec.summary = 'Single file coverage reports for SimpleCov.'
  spec.description = 'Single file coverage reports for SimpleCov.'
  spec.homepage = 'https://github.com/floor114/simplecov-single_file'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'simplecov', '~> 0.2'
  spec.add_runtime_dependency 'terminal-table', '~> 3.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'test-unit'
end
