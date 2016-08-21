class logdna::agent(
  $config_file    = '/etc/logdna.conf',
  $logfiles       = ['/var/log'],
  $key            = undef,

  $manage_repo    = true,
  $package_name   = 'logdna-agent',
  $package_ensure = 'present',

  $service_ensure  = running,
  $service_name    = 'logdna-agent',
  $service_manage  = true
) {

  validate_string($key, $config_file, $package_name, $package_ensure, $service_ensure, $service_name)
  validate_array($logfiles)
  validate_bool($manage_repo, $service_manage)

  if ! $key {
    fail('You must specify a valid LogDNA key!')
  }

  class { '::logdna::agent::package':
    package_ensure => $package_ensure,
    package_name   => $package_name,
    manage_repo    => $manage_repo,
    before         => Class['::logdna::agent::config'],
    notify         => Class['::logdna::agent::service']
  }

  class { '::logdna::agent::config':
    config_file    => $config_file,
    logfiles       => $logfiles,
    notify         => Class['::logdna::agent::service']
  }

  class { '::logdna::agent::service':
    service_ensure    => $service_ensure,
    service_name      => $service_name,
    service_manage    => $service_manage,
  }

}