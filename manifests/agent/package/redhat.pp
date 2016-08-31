# Class: logdna::agent::package::redhat
#
# This module installs the LogDNA agent on RedHat-based systems.
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
#  This module installs the LogDNA agent package on RedHat-based systems.
#
# Sample Usage:
#   This class file is not called directly
#
class logdna::agent::package::redhat(
  $package_ensure = present,
  $package_name   = 'logdna-agent',
  $manage_repo    = true
) {

  validate_string($package_ensure, $package_name)
  validate_bool($manage_repo)

  if $manage_repo {

    yumrepo { 'logdna-agent':
      baseurl  => 'http://repo.logdna.com/el6/',
      descr    => 'LogDNA packages',
      enabled  => '1',
      gpgcheck => '0',
      before   => Package['logdna-agent'],
    }

  }

  package { 'logdna-agent':
    ensure => $package_ensure,
    name   => $package_name
  }

}