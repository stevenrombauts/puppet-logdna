# Class: logdna::agent::service
#
# This module manages the LogDNA agent service.
#
# Parameters:
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
#  This module manages the LogDNA agent service.
#
# Sample Usage:
#   This class file is not called directly
#
class logdna::agent::service(
  $service_ensure   = running,
  $service_name     = 'logdna-agent',
  $service_manage   = true
) {

  validate_string($service_ensure, $service_name)
  validate_bool($service_manage)

  Package['logdna-agent']
    ~> Service['logdna-agent']

  $service_enable = $service_ensure ? {
    running => true,
    absent  => false,
    stopped => false,
    'undef' => undef,
    default => true
  }

  if $service_manage {

    service { 'logdna-agent':
      ensure     => $service_ensure,
      name       => $service_name,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => true
    }

  }

}