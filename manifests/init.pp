# == Class: module-sshkeys
#
# Full description of class module-sshkeys here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { module-sshkeys:
#    keys => [
#      { 'the_key':
#        'name'     => 'the_key',
#        'ensure'   => present,
#        'key_type' => 'dsa',
#        'key'      => 'ABCDggsndjadkfjaYFDSjdjfadj==',
#      },
#    ]
#  }
#
# === Authors
#
# Mattias Winther <mattias.winther@ericsson.com>

class module-sshkeys (
  $keys = undef,
){

  if validate_array($keys) {
    $my_keys = $keys
  } elsif validate_hash($keys) {
    $my_keys = [$keys,]
  } elsif $keys != undef {
    fail('$keys must be either an array or a hash.')
  }

  if $keys != undef {
    key_store { $my_keys: }
  }

  define key_store {
    $sshkey = $name
    ssh_authorized_key { $key['name']:
      ensure => $key['ensure'],
      user   => $key['user'],
      type   => $key['key_type'],
      key    => $key['key'],
  }

}
