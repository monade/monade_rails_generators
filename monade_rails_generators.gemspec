# frozen_string_literal: true
$:.push File.expand_path("../lib", __FILE__)

require "monade/rails/generators/version"
require "monade_rails_generators"

Gem::Specification.new do |spec|
  spec.name          = "monade_rails_generators"
  spec.version       = Monade::Rails::Generators::VERSION
  spec.authors       = ["Mònade"]
  spec.email         = ["hello@monade.io"]

  spec.summary       = "Monade Rails generators"
  spec.description   = "Monade Rails generators."
  spec.homepage      = "https://github.com/monade/monade_rails_generators"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/monade/monade_rails_generators/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir['lib/**/*']
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  # end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "lib/monade/rails/generators"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
