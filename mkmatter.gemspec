lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mkmatter/version'
Gem::Specification.new do |spec|
  spec.name = 'mkmatter'
  spec.version = Mkmatter::VERSION
  spec.authors = ['Ken Spencer']
  spec.email = 'me@iotaspencer.me'
  spec.summary = %q{Script facilitating easy content creation and generation for Jekyll Sites}
  spec.description = %q{A gem that helps a user maintain a jekyll site source directory.}
  spec.homepage = 'https://iotaspencer.me/projects/mkmatter'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata = {
        'github_repo'       => 'https://github.com/IotaSpencer/mkmatter',
        'bug_tracker_uri'   => 'https://github.com/IotaSpencer/mkmatter/issues',
        #'documentation_uri' => 'https://rubydoc.info/gems/mkmatter', no API
        'homepage_uri'      => 'https://iotaspencer.me/projects/mkmatter',
        'source_code_uri'   => 'https://github.com/IotaSpencer/mkmatter',
        'wiki_uri'          => 'https://github.com/IotaSpencer/mkmatter/wiki'
    }
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test)/})
  end
  spec.required_ruby_version = '~> 3'
  spec.bindir = 'bin'
  spec.executables << 'mkmatter'
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'highline', '~> 3.0.1'
  spec.add_runtime_dependency 'activesupport', '~> 7.1.3.2'
  spec.add_runtime_dependency 'git', '~> 1.19.1'
  spec.add_runtime_dependency 'slugity', '~> 1.1'
  spec.add_runtime_dependency 'thor', '~> 1.3.1'
  spec.add_runtime_dependency 'terminal-table', '~> 3.0.2'
  spec.add_runtime_dependency 'os', '~> 1.1.4'
  spec.add_runtime_dependency 'paint', '~> 2.3.0'
  spec.add_runtime_dependency 'front_matter_parser', '~> 1.0.1'
  spec.add_runtime_dependency 'rake', '13.1.0'
  spec.add_runtime_dependency 'micro_install', '~> 0.4.0'
  spec.add_development_dependency 'bundler', '~> 2.3.5'
  spec.add_development_dependency 'minitest', '~> 5'
  spec.add_development_dependency 'rspec-core', '~> 3.13'
  spec.add_development_dependency 'rspec-expectations', '~> 3.13'
  spec.add_development_dependency 'rspec-mocks', '~> 3.13'
  spec.add_development_dependency 'minitest-reporters', '~> 1.6.1'
  spec.add_development_dependency 'aruba', '~> 2.2.0'
  spec.add_development_dependency 'highline-test', '~> 0.0.1'
  spec.post_install_message = [
      "Thanks for installing 'mkmatter', It means a lot to me.",
      "If you'd like to install 'micro', a text editor bundled with 'mkmatter'.",
      "Then just run 'bundle exec micro-install' or 'micro-install',",
      "depending on how you installed 'mkmatter'."
  ].join("\n")
end
