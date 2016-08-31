# Class: logdna::agent::package
#
# This module installs the LogDNA agent.
#
# Parameters:
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
# Actions:
#  This module installs the LogDNA agent package.
#
# Sample Usage:
#   This class file is not called directly
#
class logdna::agent::package(
  $package_ensure = present,
  $package_name   = 'logdna-agent',
  $manage_repo    = true
) {

  validate_string($package_ensure, $package_name)
  validate_bool($manage_repo)

  case $::osfamily {
    'redhat': {
      class { '::logdna::agent::package::redhat':
        manage_repo    => $manage_repo,
        package_ensure => $package_ensure,
        package_name   => $package_name
      }
    }
    'debian': {
      class { '::logdna::agent::package::debian':
        package_name   => $package_name,
        package_ensure => $package_ensure,
        manage_repo    => $manage_repo
      }
    }
    default: {
      if $manage_repo {
        notice('Unable to manage LogDNA repository: unsupported operating system.')
      }

      package { 'logdna-agent':
        ensure => $package_ensure,
        name   => $package_name
      }
    }
  }

}