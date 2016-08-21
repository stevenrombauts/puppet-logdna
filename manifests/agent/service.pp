class logdna::agent::service(
  $service_ensure   = running,
  $service_name     = 'logdna-agent',
  $service_manage   = true
) {

  validate_string($service_ensure, $service_name)
  validate_bool($service_manage)

  $service_enable = $service_ensure ? {
    running => true,
    absent  => false,
    stopped => false,
    'undef' => undef,
    default => true
  }

  if $service_manage {

    service { 'nginx':
      ensure     => $service_ensure,
      name       => $service_name,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => true
    }

  }

}