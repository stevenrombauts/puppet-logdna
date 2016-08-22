# Class: logdna::agent::config
#
# This module configures the LogDNA agent.
#
# Parameters:
#   [*config_file*]
#     Path to the agent's configuration file.
#     Default: '/etc/logdna.conf'
#
#   [*logdir*]
#     An array of directories, files and glob patters that
#     the agent should watch for log entries.
#     Default: ['/var/log']
#
#   [*key*]
#     Your LogDNA API key
#     Default: undef
#
# Actions:
#  This module configures the LogDNA agent.
#
# Sample Usage:
#   This class file is not called directly
#
class logdna::agent::config(
  $config_file    = '/etc/logdna.conf',
  $logdir         = ['/var/log'],
  $key            = undef
) {

  validate_string($key, $config_file)
  validate_array($logdir)

  if ! $key {
    fail('You must specify a valid LogDNA key!')
  }

  $logdir_real = join($logdir, ',')

  file { 'logdna-agent':
    path    => $config_file,
    content => template('logdna/agent/logdna.conf.erb')
  }

}