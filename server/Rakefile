require "rspec/core/rake_task"
require 'rake/clean'

# setup globs for :clean task; see 'rake/clean' docs
CLEAN.include 'tmp/*'
CLEAN.include '*.log'

namespace :test do
  RSpec::Core::RakeTask.new(:all)
end
