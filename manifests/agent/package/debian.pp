# Class: logdna::agent::package::debian
#
# This module installs the LogDNA agent on Debian-based systems.
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
#  This module installs the LogDNA agent package on Debian-based systems.
#
# Sample Usage:
#   This class file is not called directly
#
class logdna::agent::package::debian(
  $package_ensure = present,
  $package_name   = 'logdna-agent',
  $manage_repo    = true
) {

  validate_string($package_ensure, $package_name)
  validate_bool($manage_repo)

  if $manage_repo {

    include ::apt

    Exec['apt_update']
      -> Package['logdna-agent']

    ::apt::source { 'logdna-agent':
      comment  => 'This is the official LogDNA agent repository',
      location => 'http://repo.logdna.com',
      release  => 'stable',
      repos    => 'main',
      key      => {
        id     => '02E0C689A9FCC8110A8FECB9C1BF174AEF506BE8',
        source => 'http://repo.logdna.com/logdna.gpg'
      }
    }

  }

  package { 'logdna-agent':
    ensure => $package_ensure,
    name   => $package_name
  }

}