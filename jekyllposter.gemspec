lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyllposter/version'

Gem::Specification.new do |spec|
  spec.name = 'jekyllposter'
  spec.version = Jekyllposter::VERSION
  spec.authors = ['Ken Spencer']
  spec.email = ['ken@electrocode.net']

  spec.summary = %q{Script facilitating a easy use of Jekyll}
  spec.description = 'A HighLine script that prompts users through setting up a Jekyll page, post, or draft. '
  spec.homepage = 'https://github.com/IotaSpencer/jekyllposter'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata = {
        'github_repo'       => 'https://github.com/IotaSpencer/jekyllposter',
        'bug_tracker_uri'   => 'https://github.com/IotaSpencer/jekyllposter/issues',
        'documentation_uri' => 'https://rubygems.org/gems/jekyllposter',
        'homepage_uri'      => 'https://iotaspencer.me/projects/jekyllposter',
        'source_code_uri'   => 'https://github.com/IotaSpencer/jekyllposter',
        'wiki_uri'          => 'https://github.com/IotaSpencer/jekyllposter'
    }
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'bin'
  spec.executables << 'mkmatter'
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'highline', '~> 1.7'
  spec.add_runtime_dependency 'activesupport', '~> 5.1'
  spec.add_runtime_dependency 'git', '~> 1.3'
  spec.add_runtime_dependency 'slugity', '~> 1.1'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
end
