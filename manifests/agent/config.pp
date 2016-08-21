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