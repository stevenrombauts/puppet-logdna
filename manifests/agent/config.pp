class logdna::agent::config(
  $config_file    = '/etc/logdna.conf',
  $logfiles       = ['/var/log'],
  $key            = undef
) {

  validate_string($key, $config_file)
  validate_array($logfiles)

  if ! $key {
    fail('You must specify a valid LogDNA key!')
  }

  $logdir = join($logfiles, ',')

  file { 'logdna-agent':
    path    => $config_file,
    content => template('logdna/agent/logdna.conf.erb')
  }

}