# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'increasecard/utils/version'

Gem::Specification.new do |spec|
  spec.name          = 'increasecard-utils'
  spec.version       = Increasecard::Utils::VERSION
  spec.authors       = ['Santiago Ocamica']
  spec.email         = ['santiago.ocamica@increasecard.com']

  spec.summary       = 'Increasecard utils'
  spec.description   = 'Utility modules for date and encoding managing'
  spec.homepage      = 'https://github.com/IncreaseCard/increasecard-utils'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'

  spec.add_runtime_dependency 'timecop', '~> 0.7'
  spec.add_runtime_dependency 'activesupport', '~> 4.2', '>= 4.2.6'
end
