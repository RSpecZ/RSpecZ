
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspecz/version"

Gem::Specification.new do |spec|
  spec.name          = "rspecz"
  spec.version       = RSpecZ::VERSION
  spec.authors       = ["yazumoto"]
  spec.email         = ["app.zenn@gmail.com"]

  spec.summary       = %q{Provide functions for smart RSpec.}
  spec.homepage      = "https://github.com/RSpecZ/RSpecZ"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rspec', '>= 3.0'
  spec.add_dependency 'method_source', '~> 1.0.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency 'pry'
end
