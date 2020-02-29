lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lichess/version"

Gem::Specification.new do |spec|
  spec.name          = "ruby-lichess"
  spec.version       = Lichess::VERSION
  spec.authors       = ["omgrr"]
  spec.email         = ["jerwis0731@gmail.com"]

  spec.summary       = %q{Ruby library for lichess api}
  spec.description   = %q{Ruby library for lichess api}
  spec.homepage      = "https://github.com/omgrr/ruby-lichess.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ndjson", "~> 1.0"
  spec.add_dependency "http", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "dotenv", "2.5.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
end
