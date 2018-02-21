lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mkmatter/version'
require 'mkmatter/gem_info'
Gem::Specification.new do |spec|
  spec.name = Mkmatter::GEM_NAME
  spec.version = Mkmatter::VERSION
  spec.authors = ['Ken Spencer']
  spec.email = 'me@iotaspencer.me'
  spec.summary = Mkmatter::SUMMARY
  spec.description = Mkmatter::DESC
  spec.homepage = 'https://iotaspencer.me/projects/mkmatter'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata = {
        'github_repo'       => 'https://github.com/IotaSpencer/mkmatter',
        'bug_tracker_uri'   => 'https://github.com/IotaSpencer/mkmatter/issues',
        'documentation_uri' => 'https://rubydoc.info/gems/mkmatter',
        'homepage_uri'      => 'https://iotaspencer.me/projects/mkmatter',
        'source_code_uri'   => 'https://github.com/IotaSpencer/mkmatter',
        'wiki_uri'          => 'https://github.com/IotaSpencer/mkmatter/wiki'
    }
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.required_ruby_version = '~> 2'
  spec.bindir = 'bin'
  spec.executables << 'mkmatter'
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'highline', '~> 1.7'
  spec.add_runtime_dependency 'activesupport', '~> 5.1'
  spec.add_runtime_dependency 'git', '~> 1.3'
  spec.add_runtime_dependency 'slugity', '~> 1.1'
  spec.add_runtime_dependency 'commander', '~> 4.4'
  spec.add_runtime_dependency 'terminal-table', '~> 1.8'
  spec.add_runtime_dependency 'os', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'aruba', '~> 0.14'
  #spec.add_development_dependency 'rspec', '~> 3.7', '>= 3.7.0'
  #spec.add_development_dependency 'rspec-core', '~> 3.7', '>= 3.7.0'
  #spec.add_development_dependency 'rspec-mocks', '~> 3.7', '>= 3.7.0'
  #spec.add_development_dependency 'rspec-expectations', '~> 3.7', '>= 3.7.0'

end
