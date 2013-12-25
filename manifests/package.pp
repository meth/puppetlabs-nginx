# Class: nginx::package
#
# This module manages NGINX package installation
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::package
(
    $nx_package_ensure = present,
)
{
  anchor { 'nginx::package::begin': }
  anchor { 'nginx::package::end': }

  case $::operatingsystem {
    centos,fedora,rhel,redhat,scientific: {
      class { 'nginx::package::redhat':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
        nx_package_ensure => $nx_package_ensure,
      }
    }
    debian,ubuntu: {
      class { 'nginx::package::debian':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
        nx_package_ensure => $nx_package_ensure,
      }
    }
    opensuse,suse: {
      class { 'nginx::package::suse':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
        nx_package_ensure => $nx_package_ensure,
      }
    }
  }
}
