# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acts_as_recursive_tree/version'

Gem::Specification.new do |spec|
  spec.name        = 'acts_as_recursive_tree'
  spec.version     = ActsAsRecursiveTree::VERSION
  spec.authors     = ['Wolfgang Wedelich-John', 'Willem Mulder']
  spec.email       = ['wolfgang.wedelich@1und1.de', '14mRh4X0r@gmail.com']
  spec.summary     = %q{Drop in replacement for acts_as_tree but using recursive queries}
  spec.description = %q{
  This is a ruby gem that provides drop in replacement for acts_as_tree but makes use of SQL recursive statement. Be sure to have a DBMS that supports recursive queries when using this gem (e.g. PostgreSQL or SQLite). }
  spec.homepage    = 'https://github.com/1and1/acts_as_recursive_tree'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 2.0.0'
  spec.files                 = `git ls-files -z`.split("\x0")
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files            = spec.files.grep(%r{^spec/})
  spec.require_paths         = ['lib']

  spec.add_runtime_dependency 'activerecord', '>= 5.0.0', '< 6.2.0'

  spec.add_development_dependency 'database_cleaner', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.5'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
  spec.add_development_dependency 'appraisal', '~> 2.4'
end
