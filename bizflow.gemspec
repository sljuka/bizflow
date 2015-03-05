# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bizflow/version'

Gem::Specification.new do |spec|
  spec.name          = "bizflow"
  spec.version       = Bizflow::VERSION
  spec.authors       = ["DSljukic"]
  spec.email         = ["uraniumsheep@gmail.com"]
  spec.summary       = %q{DSL for business processes.}
  spec.description   = %q{DSL for buisness processes.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'sqlite3', '~> 1.3.10'
  spec.add_runtime_dependency 'sequel'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "database_cleaner"
end
