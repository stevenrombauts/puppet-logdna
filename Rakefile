require 'rake'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.send('relative')
PuppetLint.configuration.send('disable_autoloader_layout')

task :default => [:lint]