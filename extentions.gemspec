# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extentions/version'

Gem::Specification.new do |gem|
  gem.name          = "extentions"
  gem.version       = Extentions::VERSION
  gem.authors       = ["Alexander Paramonov"]
  gem.email         = ["alexander.n.paramonov@gmail.com"]
  gem.summary       = %q{Plug functionality to the application}
  gem.description   = %q{Allows to create an isolated functionality and plug it into the application}
  gem.homepage      = "http://github.com/AlexParamonov/extentions"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 2.6"
end

