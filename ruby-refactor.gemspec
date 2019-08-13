
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruby_refactor/version"

Gem::Specification.new do |spec|
  spec.name          = "ruby-refactor"
  spec.version       = Ruby::Refactor::VERSION
  spec.authors       = ["Colin Williams"]
  spec.email         = ["lackita@gmail.com"]

  spec.summary       = %q{Automatic refactoring tool for ruby}
  spec.description   = %q{Currently trying to appease bundler, will write something more involved when I'm not on my phone}
  spec.homepage      = "https://home.colinwilliams.name"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://home.colinwilliams.name"
    spec.metadata["changelog_uri"] = "https://home.colinwilliams.name"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard", "~> 2.15.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7.3"
  spec.add_development_dependency "byebug"

  spec.add_dependency "parser", "~> 2.6.3"
  spec.add_dependency "unparser", "~> 0.4.5"
end
