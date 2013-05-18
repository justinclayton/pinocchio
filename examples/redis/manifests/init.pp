## Installs and configures redis from epel
class redis {

  # resources
  include epel

  package { 'redis':
    ensure => installed,
  }

  file { '/etc/redis.conf':
    ensure  => file,
    content => template('redis/redis.conf.erb'),
  }

  service { 'redis':
    ensure => running,
    enable => true,
  }

  # relationships
  Class['epel']           -> Package['redis']
  Package['redis']        -> File['/etc/redis.conf']
  File['/etc/redis.conf'] ~> Service['redis']

}