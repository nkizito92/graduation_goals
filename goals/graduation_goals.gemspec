require_relative 'lib/graduation_goals/version'

Gem::Specification.new do |spec|
  spec.name          = "graduation_goals"
  spec.version       = GraduationGoals::VERSION
  spec.authors       = ["nkizito92"]
  spec.email         = ["nkizito57@gmail.com"]

  spec.summary       = "View Goals of other users and create your on goals."
  spec.homepage      = "https://github.com/nkizito92/graduation_goals"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nkizito92/graduation_goals"
  spec.metadata["changelog_uri"] = "https://github.com/nkizito92/graduation_goals/commit/master"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
