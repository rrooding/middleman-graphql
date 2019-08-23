lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "middleman-graphql/version"

Gem::Specification.new do |spec|
  spec.name          = "middleman-graphql"
  spec.version       = MiddlemanGraphql::VERSION
  spec.authors       = ["Ralph Rooding"]
  spec.email         = ["ralph@ralphrooding.com"]

  spec.summary       = %q{Middleman GraphQL extension}
  spec.description   = %q{Middleman GraphQL extension}
  spec.homepage      = "https://github.com/rrooding/middleman-graphql"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rrooding/middleman-graphql"
  spec.metadata["changelog_uri"] = "https://github.com/rrooding/middleman-graphql"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'graphlient', '~> 0.3'
  spec.add_dependency 'middleman-cli', '~> 4.0'
  spec.add_dependency 'middleman-core', '~> 4.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
