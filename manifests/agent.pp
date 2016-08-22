# Class: logdna::agent
#
# This module manages the LogDNA agent.
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
#   [*manage_repo*]
#     Include official LogDNA agent repository to install the package from
#     Default: true
#
#   [*package_name*]
#     The name of the package to install
#     Default: 'logdna-agent'
#
#   [*package_ensure*]
#     What state the package should be in
#     Default: present
#
#   [*service_ensure*]
#     What state the service should be in, running or stopped.
#     Default: running
#
#   [*service_name*]
#     Name of the service
#     Default: 'logdna-agent'
#
#   [*service_manage*]
#     Whether to manage the server through Puppet or not
#     Default: true
#
# Actions:
#  This module installs the LogDNA agent and configures it.
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#  puppetlabs-apt - https://github.com/puppetlabs/puppetlabs-apt
#
# Sample Usage:
#   node default {
#     class { '::logdna::agent':
#        key => 'your API key'
#     }
#   }
#
class logdna::agent(
  $config_file    = '/etc/logdna.conf',
  $logdir         = ['/var/log'],
  $key            = undef,

  $manage_repo    = true,
  $package_name   = 'logdna-agent',
  $package_ensure = present,

  $service_ensure  = running,
  $service_name    = 'logdna-agent',
  $service_manage  = true
) {

  validate_string($key, $config_file, $package_name, $package_ensure, $service_ensure, $service_name)
  validate_array($logdir)
  validate_bool($manage_repo, $service_manage)

  if ! $key {
    fail('You must specify a valid LogDNA key!')
  }

  Class['::logdna::agent::package']
    -> Class['::logdna::agent::config']
    ~> Class['::logdna::agent::service']

  class { '::logdna::agent::package':
    package_ensure => $package_ensure,
    package_name   => $package_name,
    manage_repo    => $manage_repo,
    notify         => Class['::logdna::agent::service']
  }

  class { '::logdna::agent::config':
    config_file => $config_file,
    logdir      => $logdir,
    key         => $key,
    notify      => Class['::logdna::agent::service']
  }

  class { '::logdna::agent::service':
    service_ensure => $service_ensure,
    service_name   => $service_name,
    service_manage => $service_manage
  }

}