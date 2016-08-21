class logdna::agent::package(
  $package_ensure = 'present',
  $package_name   = 'logdna-agent',
  $manage_repo    = true
) {

  validate_string($package_ensure, $package_name)
  validate_bool($manage_repo)

  package { 'logdna-agent':
    ensure => $package_ensure,
    name   => $package_name
  }

  if $manage_repo {

    include '::apt'

    Exec['apt_update']
      -> Package['logdna-agent']

    ::apt::source { 'logdna-agent':
      comment  => 'This is the official LogDNA agent repository',
      location => 'http://repo.logdna.com',
      release  => 'stable',
      repos    => 'main',
      key      => '02E0C689A9FCC8110A8FECB9C1BF174AEF506BE8'
    }

  }

}