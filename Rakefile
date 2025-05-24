require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:test)
RSpec::Core::RakeTask.new(:spec)

# Rake::TestTask.new do |t|
#   t.test_files = FileList['test/**/*_test.rb']
#   t.libs = ['../lib/mkmatter.rb']
#   t.warning = false
# end

desc 'Run tests'
task default: :test